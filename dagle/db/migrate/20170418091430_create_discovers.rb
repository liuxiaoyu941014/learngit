class CreateDiscovers < ActiveRecord::Migration[5.0]
  def change
    create_table :discovers do |t|
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
