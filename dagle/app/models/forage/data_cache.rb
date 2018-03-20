class Forage::DataCache < ApplicationRecord
  audited

  store_accessor :data, :migrate_to, :catalog_id, :matched_status, :matched_ids, :matched_id, :can_purchase, :external_purchase_url, :keywords, :image, :description, :content, :date, :time, :address_line1, :address_line2, :phone, :price, :from, :site_name, :note, :original_catalog, :district_from
  belongs_to :source, polymorphic: true
  belongs_to :processed_user, class_name: 'User', foreign_key: :processed_by

  MIGRATE_TO_HASH = {
    "product": "产品",
    "site": "场馆",
    "cms_page": "新闻"
  }

  MATCHED_STATUS = {
    "multiple": "重复匹配",
    "only_one": "唯一匹配",
    "none": "暂无匹配"
  }

  enum is_merged: {
    unmerged: 0, # 未合并
    merged: 1, # 已合并
    cancelled: 2 # 取消
  }
end
