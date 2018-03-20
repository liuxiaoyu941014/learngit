class ImportInformation < ApplicationRecord
  #audited

  store_accessor :features, :name, :province, :real_city, :city, :district, :address_str, :telephone, :lat, :lng, :tags, :image,
                 :uid, :street, :keyword,
                 :is_published, :big_cate, :small_cate, :business_area, :business_hours, :avg_price, :parking, :recommendation, :good_summary, :bad_summary
end
