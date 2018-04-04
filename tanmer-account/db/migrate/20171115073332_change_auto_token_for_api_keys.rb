class ChangeAutoTokenForApiKeys < ActiveRecord::Migration[5.1]
  def change
    change_column :api_keys, :auth_token, :string, default: nil, null: true, index: true
  end
end
