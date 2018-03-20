class CreateRefunds < ActiveRecord::Migration[5.0]
  def change
    create_table :refunds do |t|
      t.references :user, foreign_key: true
      t.string :pingpp_charge_id
      t.string :event_id
      t.string :order_no
      t.text :description
      t.string :charge
      t.string :amount
      t.string :created
      t.string :charge_order_no
      t.string :succeed
      t.string :status
      t.string :time_succeed
      t.string :failure_code
      t.string :failure_msg

      t.timestamps
    end
  end
end
