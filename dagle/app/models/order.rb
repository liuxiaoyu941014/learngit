# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  code                     :string
#  user_id                  :integer
#  site_id                  :integer
#  price                    :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  description              :text
#  status                   :integer
#  internal_status          :integer
#  member_id                :integer
#  preorder_conversition_id :integer
#  create_by                :integer
#  update_by                :integer
#

class Order < ApplicationRecord
  audited
  if Settings.project.sxhop? || Settings.project.imolin? || Settings.project.wgtong?
    store_accessor :features, :delivery_username, :delivery_phone, :delivery_address, :delivery_fee,
      :member_attributes
  end
  if Settings.project.meikemei?
    store_accessor :features, :staff_id, :service_time
  end
  if Settings.project.sxhop? || Settings.project.imolin? || Settings.project.meikemei? || Settings.project.wgtong?
    enum status: {
      open: 0,      # 未付款
      pending: 1,   # 付款中
      paid: 2,      # 已付款
      cancelled: 3, # 已取消
      delivering: 4,# 发货中
      completed: 5, # 已完成
    }
    enum refund_status: {
      apply_refund: 1, # 申请退款
      refunding: 2,    # 退款中
      refunded: 3      # 退款完成
    }
  else
    enum status: {
      processing: 0, # 处理中
      cancelled: 1,  # 已取消
      completed: 2   # 已完成
    }
  end
  if Settings.project.grand? || Settings.project.demo? || Settings.project.dagle?
    enum internal_status: {
      packing: 0,    # 拆分物料
      packed: 1,     # 完成拆分
      producing: 2,  # 生产中（表示已创建生产任务了）
      produced: 3,   # 生产完成
      delivering: 4, # 发货中
      delivered: 5   # 已收货
    }
  end

  belongs_to :user
  belongs_to :site
  # if Settings.project.dagle? || Settings.project.demo? || Settings.project.grand?
  #   belongs_to :member
  # end
  belongs_to :preorder_conversition
  belongs_to :create_user, class_name: 'User', foreign_key: :create_by
  belongs_to :update_user, class_name: 'User', foreign_key: :update_by
  belongs_to :apply_refund_user, class_name: 'User', foreign_key: :apply_refund_by

  has_many_comments
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  has_many :order_materials, dependent: :destroy
  has_many :materials, through: :order_materials
  has_many :image_item_relations, as: :relation, dependent: :destroy
  has_many :image_items, :through => :image_item_relations
  has_many :attachment_relations, as: :relation, dependent: :destroy
  has_many :attachments, :through => :attachment_relations
  has_many :order_cvs, dependent: :destroy
  has_many :order_deliveries, dependent: :destroy
  has_one :produce, dependent: :destroy
  has_many :finance_histories, as: :owner, dependent: :destroy
  has_one :charge, dependent: :destroy
  has_one :refund, dependent: :destroy

  # has_many :order_members
  # accepts_nested_attributes_for :order_members, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  before_create :generate_code
  # before_validation :check_member

  validates_presence_of :site
  # validates_presence_of :member_name, message: '客户名称错误'
  # validates_presence_of :member
  validates_uniqueness_of :code

  # attr_accessor :mobile_phone, :member_name
  #
  if Settings.project.grand? || Settings.project.demo? || Settings.project.dagle?
    belongs_to :member
    validates_presence_of :member
    # validates_presence_of :delivery_date
  end

  if Settings.project.sxhop? || Settings.project.imolin? || Settings.project.meikemei?
    validates_presence_of :refund_description, :apply_refund_user, if: ->(order) { order.refund_status == 'apply_refund' }
  end

  after_initialize do
    self.status ||= 0
    self.internal_status ||= 0
  end

  before_save do
    if self.price.blank?
      self.price = 0
    end
    if Settings.project.grand? || Settings.project.demo? || Settings.project.dagle?
      self.user = self.member.user
    end
    # 判断是否要发支付成功的短信
    @should_send_paid_message = self.status_change == ['open', 'paid'] || self.status_change == ['pending', 'paid']
    # self.user = self.member.user
    # 订单状态改变消息提醒
    if self.status_changed? && !self.new_record? && self.user
      if Settings.project.sxhop? || Settings.project.imolin? || Settings.project.meikemei? || Settings.project.wgtong?
        content = nil
        case self.status
        when 'paid'
          content = '有新的订单已支付: '
        when 'cancelled'
          content = '订单已取消: '
        when 'completed'
          content = '订单已完成: '
        end
        Notification.notice(self.site.user.id, nil, '订单', content + self.code.to_s, self, 'code') if content.present? && self.site.user
      else
        Notification.notice(self.site.user.id, nil, '订单', '订单状态更新了', self, 'code') if self.site.user
      end
    end
     
    if self.status_changed?
      # 支付成功后修改产品库存
      if self.paid?
        self.order_products.each do |op|
          p = op.product
          stocknu=self.member_attributes[0]["stocknu"]
          p.stock[stocknu]=p.stock[stocknu]-op.amount
          p.save!  
        end
      end
      # 确认消费后给用户发送短信通知
      if self.completed?
        OrderCompletedJob.perform_async(self.id, "由商家(#{self.site.title})")
      end
    end

    if self.refund_status_changed?
      # 订单退款成功后修改产品库存
      if self.refunded?
        self.order_products.each do |op|
          p = op.product
          stocknu=self.member_attributes[0]["stocknu"]
          p.stock[stocknu]=p.stock[stocknu]+op.amount
          p.save!
        end
      end
    end
  end

  after_commit do
    if @should_send_paid_message && (Settings.project.imolin? || Settings.project.meikemei? || Settings.project.wgtong?)
      OrderNotificationJob.perform_async(self.id)
    end
  end

  def paid
    finance_histories.sum(&:amount)
  end

  def paid_status
    paid > (price/100) ? '已结清' : '未结清'
  end

  scope :undeleted, -> { where(deleted: false)}

  # def member
  #   return nil unless site
  #   return site.members.where(user: user).first if user
  #   return site.members.where(id: member_id).first
  #   nil
  # end

  private

  # def check_member
  #   if mobile_phone.blank?
  #     create_member
  #   else
  #     user = User.find_by_phone_number(mobile_phone)
  #     if user
  #       self.user_id = user.id
  #     else
  #       member = create_member
  #       self.user_id = member.try(:user_id)
  #     end
  #   end
  # end

  # def create_member
  #   member = Member.find
  #   flag, member = Member::Create.(mobile_phone: mobile_phone, name: member_name, site_id: site_id)
  #   if flag
  #     self.member_id = member.id
  #     return member
  #   else
  #     errors.add :mobile_phone, member.errors["mobile_phone"].first
  #     return nil
  #   end
  # end

  def generate_code
    return if (Settings.project.grand? || Settings.project.demo? || Settings.project.dagle?) && self.code.present?
    prefix = Time.now.strftime('%Y%m%d')
    number = self.class.where("code LIKE ?", prefix+'%').count
    loop do
      self.code = "#{prefix}#{(number + 1).to_s.rjust(3, '0')}"
      break unless self.class.where(code: self.code).exists?
      number += 1
    end
  end
end
