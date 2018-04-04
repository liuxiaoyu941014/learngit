class AddIsSsoToOauthApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :oauth_applications, :is_sso, :boolean, default: false
  end
end
