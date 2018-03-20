class AddIsPublishedToMarketTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :market_templates, :is_published, :boolean, default: true
  end
end
