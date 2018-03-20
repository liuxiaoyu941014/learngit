class Admin::Forage::BaseController < Admin::BaseController

  private
    # get the match sources before merge the data
    def get_matched_source
      # matched_ids
      multiple_ids = case @forage_data_cache.matched_status
      when 'multiple'
        @forage_data_cache.matched_ids.split(/\s*,\s*/)
      when 'only_one'
        [@forage_data_cache.matched_id]
      end
      # matched sources
      @multiple_sources, @catalogs = case @forage_data_cache.migrate_to
      when 'product'
        [Product.where(id: multiple_ids).map{|p| [p.id, p.name, admin_site_product_path(p.site, p)]}, ProductCatalog.roots.map{|c| [c.name, c.id]}]
      when 'site'
        [Site.where(id: multiple_ids).map{|s| [s.id, s.title, admin_site_path(s)]}, SiteCatalog.roots.map{|c| [c.name, c.id]}]
      when 'cms_page'
        [::Cms::Page.where(id: multiple_ids).map{|c| [c.id, c.title, '']}, ::Cms::Site.all.map{|c| [c.name, c.id]}]
      end
    end

    # generate the match sources when merge the data
    def generate_source
      assign_paramter_hash = params[:forage_data_cache]
      # get matched_id
      matched_id = assign_paramter_hash[:matched_id] || @forage_data_cache.matched_id
      # special parameters
      if @forage_data_cache.migrate_to == 'product'
        site_id = assign_paramter_hash[:site_id].blank? ? Site::MAIN_ID : assign_paramter_hash[:site_id]
        @merge_source = matched_id.blank? ? Product.new(name: assign_paramter_hash[:title], catalog_id: assign_paramter_hash[:catalog_id], site_id: site_id) : Product.find(matched_id)
        @merge_source.image         = assign_paramter_hash[:image]
        @merge_source.address_line1 = assign_paramter_hash[:address_line1]
        @merge_source.address_line2 = assign_paramter_hash[:address_line2]
        @merge_source.date          = assign_paramter_hash[:date]
        @merge_source.time          = assign_paramter_hash[:time]
        @merge_source.phone         = assign_paramter_hash[:phone]
        @merge_source.content       = assign_paramter_hash[:content]
        @merge_source.can_purchase  = assign_paramter_hash[:can_purchase]
        @merge_source.external_purchase_url = assign_paramter_hash[:external_purchase_url]
        @merge_source.forage_price  = assign_paramter_hash[:price]
      elsif @forage_data_cache.migrate_to == 'site'
        @merge_source = matched_id.blank? ? Site.new(title: assign_paramter_hash[:title], catalog_id: assign_paramter_hash[:catalog_id]) : Site.find(matched_id)
        @merge_source.phone         = assign_paramter_hash[:phone]
        @merge_source.content       = assign_paramter_hash[:content]
        @merge_source.address_line  = assign_paramter_hash[:address_line1]
      elsif @forage_data_cache.migrate_to == 'cms_page'
        @merge_source = matched_id.blank? ? Cms::Page.new(title: assign_paramter_hash[:title], channel_id: assign_paramter_hash[:catalog_id]) : Cms::Page.find(matched_id)
        @merge_source.keywords      = assign_paramter_hash[:keywords]
        @merge_source.content       = assign_paramter_hash[:content]
        @merge_source.image_path    = assign_paramter_hash[:image]
      end

      # common parameters
      @merge_source.forage_url = assign_paramter_hash[:url] || @forage_data_cache.url
      @merge_source.forage_from = assign_paramter_hash[:from]
      @merge_source.forage_district_from = assign_paramter_hash[:district_from]
      @merge_source.forage_image = assign_paramter_hash[:image]
      @merge_source.is_foraged = true
    end

    # generaete the redirect url after merged the data
    def source_redirect_url
      source_url = case @forage_data_cache.migrate_to
      when 'product'
        edit_admin_site_product_path(@forage_data_cache.source.site, @forage_data_cache.source)
      when 'site'
        edit_admin_site_path(@forage_data_cache.source)
      when 'cms_page'
        # admin_forage_data_cach_path(@forage_data_cache.source)
        edit_admin_cms_site_channel_page_path(@forage_data_cache.source.channel.site, @forage_data_cache.source.channel, @forage_data_cache.source)
      end
    end

end
