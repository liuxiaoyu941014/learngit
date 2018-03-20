class CreateTrackerShareCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :tracker_share_codes do |t|
      t.references :user, index: true
      t.references :resource, polymorphic: true
      t.string :url

      t.timestamps
    end
  end
end
