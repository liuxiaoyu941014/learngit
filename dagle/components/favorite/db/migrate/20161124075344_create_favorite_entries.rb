class CreateFavoriteEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_entries do |t|
      t.references :user
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
