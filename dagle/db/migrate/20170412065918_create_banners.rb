class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.string :title
      t.integer :banner_type
      t.string :image_url
      t.string :redirect_web_url
      t.string :redirect_app_url
      t.jsonb :features

      t.timestamps
    end
  end
end
