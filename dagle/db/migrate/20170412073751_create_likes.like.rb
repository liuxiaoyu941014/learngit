# This migration comes from like (originally 20170412071929)
class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :resource, polymorphic: true

      t.timestamps
    end
  end
end
