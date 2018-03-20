# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  site_id      :integer
#  name         :string
#  birth        :date
#  email        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mobile_phone :string
#  tel_phone    :string
#  wechat       :string
#  firm         :string
#  address      :string
#  note         :string
#  features     :jsonb
#  qq           :string
#  typo         :string
#  from         :string
#  owned        :string
#

class Member < ApplicationRecord
  audited
  belongs_to :user
  # validates_presence_of :user
  # validates_uniqueness_of :user_id, scope: :site_id
  belongs_to :site
  validates_presence_of :site, :name
  validates :email, email: true, allow_blank: true
  validates :qq, qq: true, allow_blank: true
  validates_uniqueness_of :name, scope: [:site_id, :user_id]
  validates :mobile_phone, mobile_phone: true, allow_blank: true
  #validates_uniqueness_of :mobile_phone, scope: [:site_id, :user_id]
  before_validation :create_user, if: -> { user_id.blank? && mobile_phone.present? }
  has_many :member_notes, dependent: :destroy
  has_many :orders

  store_accessor :features, :card_id, :real_name

  def last_updated_at
    member_notes.any? ? member_notes.last.updated_at : updated_at
  end

  def orders
    Order.where(member_id: id)
  end

  private
  def create_user
    user = User.find_by_phone_number(mobile_phone)
    if user
      if Member.exists?(site_id: site_id, user_id: user.id)
        errors.add :mobile_phone, "手机号已经存在"
      else
        self.user_id = user.id
      end
    else
      flag, user = User::Create.(mobile_phone: mobile_phone, nickname: name)
      if flag
        self.user_id = user.id
      else
        errors.add :mobile_phone, "手机号错误"
      end
    end
  end

end
