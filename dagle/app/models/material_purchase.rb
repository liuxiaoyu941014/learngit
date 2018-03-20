# == Schema Information
#
# Table name: material_purchases
#
#  id         :integer          not null, primary key
#  vendor_id  :integer
#  features   :jsonb
#  created_by :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#

class MaterialPurchase < ApplicationRecord
  audited
  has_associated_audits
  belongs_to :vendor
  validates :vendor, presence: true
  store_accessor :features, :purchase_date, :delivery_date, :amount, :paid, :total, :note
  has_many :material_purchase_details, dependent: :destroy
  accepts_nested_attributes_for :material_purchase_details, reject_if: proc { |attributes| attributes['material_id'].blank? }, allow_destroy: true
  validates :material_purchase_details, :length => { :minimum => 1,  message: "不能为空！" }
  before_create :generate_code
  belongs_to :user, :foreign_key => :created_by
  validates_uniqueness_of :code
  
  enum status: {
    uncheck: 0, #未审核
    checked: 1, #已审核
    storage: 2, #已入库
  }

  after_initialize do
    self.status ||= 0
  end

  private

  def generate_code
    purchase_code = 'CG'+Time.now.strftime('%Y%m%d')
    number = self.class.where("code LIKE ?", purchase_code+'%').count
    loop do
      number = (number + 1).to_s.rjust(4, '0') 
      self.code = "#{purchase_code}#{number}"
      break unless self.class.where(code: self.code).exists?
      number += 1
    end
  end

end
