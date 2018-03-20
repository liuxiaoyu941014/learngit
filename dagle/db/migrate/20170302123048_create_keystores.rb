class CreateKeystores < ActiveRecord::Migration[5.0]
  def change
    create_table :keystores do |t|
      t.string :key, null: false, index: true
      t.string :value, null: false
      t.string :description

      t.timestamps
    end
  end
end
