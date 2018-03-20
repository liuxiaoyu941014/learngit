# add pg array
# http://rny.io/rails/postgresql/2013/07/28/tagging-in-rails-4-using-postgresql-arrays.html
class AddPropertiesToCmsPage < ActiveRecord::Migration[5.0]
  def change
    remove_column :cms_pages, :properties
    add_column :cms_pages, :properties, :string, array: true, default: []
    add_index  :cms_pages, :properties, using: 'gin'
  end
end
