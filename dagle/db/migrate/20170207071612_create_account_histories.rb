class CreateAccountHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :account_histories do |t|
      t.references :account, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2
      t.integer :relation_account
      t.integer :relation_type
      t.date :relation_date

      t.timestamps
    end
  end
end
