class CreateMemberNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :member_notes do |t|
      t.references :member, foreign_key: true
      t.references :user, foreign_key: true
      t.text :message, null: false

      t.timestamps
    end
  end
end
