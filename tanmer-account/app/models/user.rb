# require 'des_encryptor'
require 'validators/mobile_phone_validator'
class User < ApplicationRecord
  OMNIAUTH_PROVIDERS = []
  OMNIAUTH_PROVIDERS << :gitlab if ENV['ENABLE_GITLAB_OAUTH'] == 'true'
  OMNIAUTH_PROVIDERS.freeze
  # APP_SECRET_SALT = 'NTAyODU2NT'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :lockable, :omniauthable, omniauth_providers: OMNIAUTH_PROVIDERS

  has_many :tokens, -> { where(application_id: nil) } , :foreign_key => :resource_owner_id, :class_name => 'Doorkeeper::AccessToken', :dependent => :destroy
  has_many :omniauth_users, dependent: :destroy
  has_and_belongs_to_many :roles, join_table: 'roles_users'
  has_many :permissions, through: :roles

  scope :include_permissions, -> { includes(permissions: { app: [:sources] }) }

  delegate :can?, :cannot?, :to => :ability

  before_destroy :can_destroy_me?
  validate :can_remove_admin_role?, on: :update
  validates :mobile_phone, mobile_phone: true, allow_blank: true
  #, :mobile_phone

  # mobile validation
  validates_uniqueness_of :mobile_phone, allow_blank: true
  validates_uniqueness_of :email, case_sensitive: false, allow_blank: true
  validates_uniqueness_of :username, case_sensitive: false, allow_blank: true

  validate :ensure_login_name_exists
  def ensure_login_name_exists
    check_attrs = []
    check_attrs << :mobile_phone if ENV['ENABLE_REGISTERATION_WITH_MOBILE'] == 'true'
    check_attrs << :email if ENV['ENABLE_REGISTERATION_WITH_EMAIL'] == 'true'
    check_attrs << :username if ENV['ENABLE_REGISTERATION_WITH_USERNAME'] == 'true'
    if check_attrs.map{|attr| self.send(attr).presence }.compact.empty?
      check_attrs.each do |attr|
        errors.add(attr, '至少填写其中一个')
      end
    end
  end
  # if ENV['REGISTERATION_REQUIRES_MOBILE'] == 'true'
  #   validates_presence_of :mobile_phone
  # end
  # # email validation
  #
  # if ENV['REGISTERATION_REQUIRES_EMAIL'] == 'true'
  #   validates_presence_of :email
  # end
  # # username validation
  #
  # if ENV['REGISTERATION_REQUIRES_USERNAME'] == 'true'
  #   validates_presence_of :username
  # end

  # attr_reader :__app__

  # scope :by_uid, -> (app_secret, uid) { where(id: decrypt_uid(app_secret, uid)) }

  def self.from_omniauth(auth)
    omniauth_user =
      OmniauthUser.find_or_create_by!(provider: auth.provider, uid: auth.uid) do |o_user|
        o_user.name = auth.info.name
        o_user.image = auth.info.image
        o_user.user = User.find_or_create_by!(email: auth.info.email) do |user|
          user.password = Devise.friendly_token[0,20]
          user.name = auth.info.name
          user.image = auth.info.image
        end
      end
    omniauth_user.user
  end

  # def of_app(app)
  #   old_app = @__app__
  #   @__app__ = app
  #   ret = yield self
  #   @__app__ = old_app
  #   ret
  # end

  # def uid
  #   @__app__ && id && self.class.encrypt_uid(@__app__.secret, id.to_s)
  # end

  def add_role(role)
    roles << role unless roles.exists?(role.id)
  end

  def remove_role(role)
    return false if role.id == Role::ADMIN_ID && Role.find(Role::ADMIN_ID).users.where("id != ?", id).empty?
    roles.delete(role) if roles.exists?(role.id)
  end

  # 判断其他用户（非current_user）的权限,  使用方法: user.can? :create, User
  def ability
    @ability ||= Ability.new(self)
  end

  # def permission_keys
  #   (@__app__ && permissions.where(app: @__app__).map(&:key)) || []
  # end

  # def as_json(options={})
  #   options = options.symbolize_keys
  #   app = options.delete(:app)
  #   show_uid = false
  #   if Array(options[:methods]).map(&:to_s).include?('uid')
  #     show_uid = true
  #     options[:methods] = Array(options[:methods]).select{ |v| v.to_s != 'uid' }
  #     raise "当获取uid时，必须传入app参数: as_json(app: app, methods: [:uid])" if app.nil?
  #   end
  #   j = super(options)
  #   j['uid'] = uid(app.secret) if show_uid
  #   j
  # end

  def api_json(with_permissions: false)
    options = { only: [:id, :name, :email, :image, :sso_token, :sso_token_expires_at, :mobile_phone] }
    options.update(include: { permissions: { only: [:subject_class, :action, :subject_id], methods: [:app_uid] } }) if with_permissions
    as_json(options)
  end

  def valid_sso_token?(token)
    token == sso_token && (sso_token_expires_at.nil? || sso_token_expires_at > Time.now)
  end

  def sso_login!(expires_at=nil)
    self.sso_token ||= SecureRandom.hex(16)
    self.sso_token_expires_at = expires_at || Devise.remember_for.since
    self.save!
  end

  def sso_logout!
    Doorkeeper::AccessToken.joins(:application).
      where(resource_owner_id: id, Doorkeeper::Application.table_name => { is_sso: true } ).
      update_all(revoked_at: Time.now)
    self.sso_token = nil
    self.sso_token_expires_at = nil
    self.save!
  end

  private

  # def self.encrypt_uid(app_secret, uid)
  #   key = "#{APP_SECRET_SALT}-#{app_secret}"
  #   DesEncryptor.encrypt(key, uid)
  # end

  # def self.decrypt_uid(app_secret, uid)
  #   key = "#{APP_SECRET_SALT}-#{app_secret}"
  #   DesEncryptor.decrypt(key, uid)
  # end

  def can_destroy_me?
    if roles.exists?(id: Role::ADMIN_ID) && Role.find(Role::ADMIN_ID).users.count == 1
      errors.add :base, "最后一个管理员不能被删除"
      throw :abort
    end
  end

  def can_remove_admin_role?
    if Role.find(Role::ADMIN_ID).users.empty?
      errors.add :roles, "系统至少得有一个管理员"
    end
  end
end
