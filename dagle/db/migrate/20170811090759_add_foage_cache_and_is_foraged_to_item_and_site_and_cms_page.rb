class AddFoageCacheAndIsForagedToItemAndSiteAndCmsPage < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :forage, :jsonb, defailt: "{is_foraged: false, can_purchase: false}"
    add_index :items, "(forage ->> 'is_foraged')", name: "index_items_on_forage_is_forage"

    add_column :sites, :forage, :jsonb, defailt: "{is_foraged: false}"
    add_index :sites, "(forage ->> 'is_foraged')", name: "index_sites_on_forage_is_forage"

    add_column :cms_pages, :forage, :jsonb, defailt: "{is_foraged: false}"
    add_index :cms_pages, "(forage ->> 'is_foraged')", name: "index_cms_pages_on_forage_is_forage"
  end
end
