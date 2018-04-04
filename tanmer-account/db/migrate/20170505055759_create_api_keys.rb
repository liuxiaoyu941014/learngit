class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.uuid :auth_token, null: false, default: 'uuid_generate_v4()', index: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
