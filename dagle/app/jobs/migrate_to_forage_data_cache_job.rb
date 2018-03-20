class MigrateToForageDataCacheJob
  include Sidekiq::Worker

  def perform
    if Settings.project.wgtong?
      begin
        Forage::Detail.where(is_merged: 'n').limit(1000).each do |forage_detail|
          begin
            # first: find in data_cache
            old_caches = Forage::DataCache.where("data ->> 'migrate_to' = ? AND (title = ? OR url = ?)", forage_detail.migrate_to, forage_detail.title, forage_detail.url)
            old_cache_ids = old_caches.map(&:matched_id).uniq.compact
            if old_cache_ids.size == 1
              matched_id = old_cache_ids.first
              matched_ids = old_cache_ids
              matched_status = 'only_one'
            else
              match_source_ids = match_source(forage_detail)
              matched_ids = (match_source_ids + old_cache_ids).uniq
              matched_status, matched_id = case matched_ids.size
              when 0; ['none']
              when 1; ['only_one', matched_ids.first]
              else; ['multiple']
              end
            end
            # second: create data cache
            data_cache = Forage::DataCache.new(title: forage_detail.title, url: forage_detail.url)
            data_cache.migrate_to            = forage_detail.migrate_to
            data_cache.matched_status        = matched_status
            data_cache.matched_ids           = matched_ids.join(', ')
            data_cache.matched_id            = matched_id
            data_cache.can_purchase          = forage_detail.can_purchase
            data_cache.external_purchase_url = forage_detail.purchase_url
            data_cache.keywords              = forage_detail.keywords
            data_cache.image                 = forage_detail.image
            data_cache.description           = forage_detail.description
            data_cache.content               = forage_detail.content
            data_cache.date                  = forage_detail.date
            data_cache.time                  = forage_detail.time
            data_cache.address_line1         = forage_detail.address_line1
            data_cache.address_line2         = forage_detail.address_line2
            data_cache.phone                 = forage_detail.phone
            data_cache.price                 = forage_detail.price
            data_cache.from                  = forage_detail.from
            data_cache.site_name             = forage_detail.site_name
            data_cache.note                  = forage_detail.note
            data_cache.original_catalog      = forage_detail.original_catalog
            data_cache.district_from         = forage_detail.district_from
            data_cache.save
            forage_detail.is_merged = 'y'
          rescue => e
            puts e.message
            forage_detail.is_merged = 'f'
          end
          forage_detail.save!
        end
      end while Forage::Detail.where(is_merged: 'n').limit(1).count > 0
    end
  end

  def match_source(forage_detail)
    source_ids = if forage_detail.migrate_to == 'product'
      Product.where("name = ? OR forage ->> 'forage_url' = ?", forage_detail.title, forage_detail.url).map(&:id)
    elsif forage_detail.migrate_to == 'site'
      Site.where("title = ? OR forage ->> 'forage_url' = ?", forage_detail.title, forage_detail.url).map(&:id)
    elsif forage_detail.migrate_to == 'cms_page'
      Cms::Page.where("title = ? OR forage ->> 'forage_url' = ?", forage_detail.title, forage_detail.url).map(&:id)
    end
    source_ids
  end
end
