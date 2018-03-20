class ApiSubdomain
  def self.matches?(request)
    %w(api api-dev).include?(request.subdomain)
  end
end
