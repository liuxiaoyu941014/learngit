class AddNameToOauthAccessTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :oauth_access_tokens, :name, :string
  end
end
