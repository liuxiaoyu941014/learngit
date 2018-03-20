module AppAPI::V1
  extend ActiveSupport::Concern
  included do
    version 'v1', using: :path, vendor: 'tmf'
    format :json
    mount AppAPI::V1::Order
    mount AppAPI::V1::ShoppingCart
    mount AppAPI::V1::ProductCatalog
    mount AppAPI::V1::Product
    mount AppAPI::V1::Comment
    mount AppAPI::V1::Site
    mount AppAPI::V1::User
    mount AppAPI::V1::AppAuth
    mount AppAPI::V1::Article
    mount AppAPI::V1::ImageItem
    mount AppAPI::V1::Banner
    mount AppAPI::V1::ChatRoom
    mount AppAPI::V1::ChatMessage
    mount AppAPI::V1::Discover if Settings.project.sxhop?
    mount AppAPI::V1::Staff if Settings.project.meikemei?
    mount AppAPI::V1::ProductCatalog
    mount AppAPI::V1::SiteCatalog
    mount AppAPI::V1::Community
    mount AppAPI::V1::AddressBook
    mount AppAPI::V1::SalesDistribution
    mount AppAPI::V1::AppSettings
    mount AppAPI::V1::Complaint
    mount AppAPI::V1::ForageDetail
  end
end
