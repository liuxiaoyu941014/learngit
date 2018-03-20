require File.expand_path('../../config/environment', __FILE__)
class UploadIconToSiteCatalog
  def run
    SiteCatalog.all.each do |site_catalog|
      site_catalog.icon_url = "#{Settings.site.host}/icons/#{URI::escape(site_catalog.name)}.png"
      site_catalog.save!
    end
  end
end

if $0 == __FILE__
  UploadIconToSiteCatalog.new.run
end
