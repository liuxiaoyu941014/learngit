class FinanceBill < ApplicationRecord
  audited
  enum status: {
      open: 0,      # 申请中
      checked: 1,   # 已审核
      cashed: 2,    # 已付款
    }
  belongs_to :site
  before_create :generate_code

  private
    def generate_code
      prefix = Time.now.strftime('%Y%m%d')
      number = self.class.where("code LIKE ?", prefix+'%').count
      loop do
        self.code = "#{prefix}#{(number + 1).to_s.rjust(3, '0')}"
        break unless self.class.where(code: self.code).exists?
        number += 1
      end
    end
end
