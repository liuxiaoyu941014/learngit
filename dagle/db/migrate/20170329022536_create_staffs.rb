class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
    	t.references :user, index: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
