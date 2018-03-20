class CreateFinanceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :finance_histories do |t|
      t.date :operate_date
      t.decimal :amount, precision: 8, scale: 2
      t.integer :operate_type
      t.references :owner, polymorphic: true
      t.integer :created_by

      t.timestamps
    end
  end
end
