class AddColumnContentToMarketPage < ActiveRecord::Migration[5.0]
  def change
    add_column :market_pages, :content, :text
  end
end
