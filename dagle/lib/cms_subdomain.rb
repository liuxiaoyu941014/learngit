require 'api_subdomain'
require 'root_domain'
module CmsSubdomain
  def self.matches?(request)
    request.subdomain.present? &&
    !RootDomain.matches?(request) &&
    !ApiSubdomain.matches?(request) &&
    !DocSubdomain.matches?(request)
  end
end
