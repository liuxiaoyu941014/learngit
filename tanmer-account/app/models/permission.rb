class Permission < ApplicationRecord
  belongs_to :app, class_name: 'Doorkeeper::Application'
  validates_presence_of :app, :name, :group_name, :subject_class, :action
  validates_uniqueness_of :action, scope: [:app_id, :subject_class]

  has_and_belongs_to_many :roles, join_table: 'roles_permissions'
  delegate :uid, to: :app, prefix: true

  def friendly_name
    [name, group_name].compact.join
  end

  def name_with_action
    "#{name}(#{action})"
  end

  # def key
  #   "#{friendly_name}|#{action}|#{subject_class}|#{subject_id}"
  # end
end
