class Site
  Destroy =
    lambda do |site_or_id, user: nil|
      site = site_or_id.is_a?(Site) ? site_or_id : Site.find(site_or_id)
      [site.destroy, site]
    end
end