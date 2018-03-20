class FinanceBill < ActiveRecord::Migration[5.0]
  def change
    create_table :finance_bills do |t|
      t.integer :amount
      t.integer :status

      t.timestamps
    end
  end
end
