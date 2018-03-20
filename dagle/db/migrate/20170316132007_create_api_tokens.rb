class CreateApiTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :api_tokens do |t|
      t.references :user, index: true
      t.string :token, limit: 64, index: true
      t.string :device
      t.datetime :expired_at

      t.timestamps
    end
  end
end
