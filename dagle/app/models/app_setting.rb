class AppSetting < ApplicationRecord
  audited

  store_accessor :app_data, :article_share_url_pattern, :site_share_url_pattern, :product_share_url_pattern, :system_rooms, :service_banners, :main_banners, :app_version_message, :auto_deliver_days, :auto_cancel_hours

  validates_presence_of :name, :key_word
  validates_uniqueness_of :name, scope: [:key_word]

  scope :current, -> { where(active: true).first || first }
end
