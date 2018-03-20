class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.references :order, foreign_key: true
      t.string :pingpp_charge_id
      t.string :channel
      t.string :client_ip
      t.string :transaction_no
      t.string :paid
      t.string :refunded
      t.string :time_paid
      t.string :time_created

      t.timestamps
    end
  end
end
