class AddColumnToCmsSite < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_sites, :root_domain, :string
  end
end
