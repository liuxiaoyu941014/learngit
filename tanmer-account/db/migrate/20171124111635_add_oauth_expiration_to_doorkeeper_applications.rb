class AddOauthExpirationToDoorkeeperApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :oauth_applications, :oauth_expiration, :integer
  end
end
