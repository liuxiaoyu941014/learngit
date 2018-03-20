class AddFeaturesToPages < ActiveRecord::Migration[5.0]
  def change
    remove_columns :pages, :short_title, :description
    add_column :pages, :type, :string, after: :id
    add_column :pages, :features, :jsonb
  end
end
