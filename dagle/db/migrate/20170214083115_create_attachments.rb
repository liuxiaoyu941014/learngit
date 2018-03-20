class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :owner, polymorphic: true
      t.string :name
      t.integer :file_size
      t.jsonb :data

      t.timestamps
    end
  end
end
