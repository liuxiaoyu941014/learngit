class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.references :owner, polymorphic: true
      t.string :name
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
