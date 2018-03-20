class OrderMember
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :mobile, :card_id, :product_id, :attr_validates

  validates :mobile, format: { with: /\A1\d{10}\z/i,
    message: "手机号格式不正确" }, allow_blank: true
  validates :card_id, format: { with: /\A[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)\z/,
    message: "身份证号格式不正确" }, allow_blank: true

  validate :validate_card_id_with_product_id
  validate :validate_mobile_with_product_id
  validate :validate_name_with_product_id
  # validates_presence_of :name

  def initialize(order_member)
    self.name = order_member[:name]
    self.mobile = order_member[:mobile]
    self.card_id = order_member[:card_id]
    self.product_id = order_member[:product_id]
    self.attr_validates = Product.find_by(id: self.product_id).try(:member_attribute_validates) || {}
  end

  def persisted?
    false
  end


  def validate_card_id_with_product_id
    card_id_validtes = self.attr_validates["card_id"]
    if card_id_validtes && card_id_validtes.include?('presence')
      errors.add(:card_id, "身份证号没有填写!") if self.card_id.blank?
    end
    if card_id_validtes && card_id_validtes.include?('uniqueness')
      unique_card_id_with_product_id
    end
  end

  def validate_mobile_with_product_id
    mobile_validtes = self.attr_validates["mobile"]
    if mobile_validtes && mobile_validtes.include?('presence')
      errors.add(:mobile, "手机号没有填写!") if self.mobile.blank?
    end
    if mobile_validtes && mobile_validtes.include?('uniqueness')
      unique_mobile_with_product_id
    end
  end

  def validate_name_with_product_id
    name_validtes = self.attr_validates["name"]
    if name_validtes && name_validtes.include?('presence')
      errors.add(:name, "手机号没有填写!") if self.name.blank?
    end
    if name_validtes && name_validtes.include?('uniqueness')
      unique_name_with_product_id
    end
  end

  def unique_card_id_with_product_id
    if self.product_id && self.card_id
      order_products = OrderProduct.where(product_id: self.product_id)
      order_products.each do |order_product|
        order = order_product.order
        if order.member_attributes && order.member_attributes.map{|om| om["card_id"]}.include?(self.card_id)
          errors.add(:card_id, "已经存在")
        end
      end
    end
  end

  def unique_mobile_with_product_id
    if self.product_id && self.mobile
      order_products = OrderProduct.where(product_id: self.product_id)
      order_products.each do |order_product|
        order = order_product.order
        if order.member_attributes && order.member_attributes.map{|om| om["mobile"]}.include?(self.mobile)
          errors.add(:mobile, "已经存在")
        end
      end
    end    
  end

  def unique_name_with_product_id
    if self.product_id && self.name
      order_products = OrderProduct.where(product_id: self.product_id)
      order_products.each do |order_product|
        order = order_product.order
        if order.member_attributes && order.member_attributes.map{|om| om["name"]}.include?(self.name)
          errors.add(:name, "已经存在")
        end
      end
    end
  end
end