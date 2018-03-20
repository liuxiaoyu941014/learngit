class CreateForageDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :forage_details do |t|
      t.integer :simple_id, null: false, index: true
      t.string :url, null: false
      t.string :migrate_to
      t.boolean :can_purchase, default: false
      t.string :purchase_url
      t.string :title
      t.string :keywords
      t.string :image
      t.string :description
      t.text :content
      t.string :date
      t.string :time
      t.string :address_line1
      t.string :address_line2
      t.string :phone
      t.string :price
      t.string :from
      t.boolean :has_site, default: false
      t.string :site_name
      t.string :note
      t.jsonb :features

      t.timestamps
    end
  end
end
