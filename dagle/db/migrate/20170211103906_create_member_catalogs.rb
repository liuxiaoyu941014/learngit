class CreateMemberCatalogs < ActiveRecord::Migration[5.0]
  def change
    create_table :member_catalogs do |t|
      t.string :key, null: false
      t.text :value, array:true, default: []

      t.timestamps
    end
  end
end
