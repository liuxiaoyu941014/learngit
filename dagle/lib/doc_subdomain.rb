class DocSubdomain
  def self.matches?(request)
    %w(doc).include?(request.subdomain)
  end
end
