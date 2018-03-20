class CreateOrderCvs < ActiveRecord::Migration[5.0]
  def change
    create_table :order_cvs do |t|
      t.string :cabinet_no
      t.string :cabinet_name
      t.references :order, foreign_key: true
      t.jsonb :features

      t.timestamps
    end
  end
end
