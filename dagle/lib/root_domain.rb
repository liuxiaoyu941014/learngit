#xj: 'www' and '' is a cms site, not root.
module RootDomain
  def self.matches?(request)
    request.subdomain.blank?
  end
end
