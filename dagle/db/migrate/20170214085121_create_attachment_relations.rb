class CreateAttachmentRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_relations do |t|
      t.references :attachment, foreign_key: true
      t.references :relation, polymorphic: true

      t.timestamps
    end
  end
end
