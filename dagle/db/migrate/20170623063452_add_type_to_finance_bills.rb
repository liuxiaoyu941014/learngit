class AddTypeToFinanceBills < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_bills, :code, :string
    # 名字起的可能不好, 代表是否是入账账单, 入账为商家购买了套餐成为VIP商家.
    # 默认账单为出账账单,即商家提现产生的账单
    add_column :finance_bills, :is_entry, :boolean, default: :false
  end
end
