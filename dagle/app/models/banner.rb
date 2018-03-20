class Banner < ApplicationRecord
  audited

  enum banner_type: {
    main: 0,      # app首页
    privated: 1,  # app私藏界面
    discover: 2,  # app发现界面
  }

  store_accessor :features, :description
  validates_presence_of :title, :banner_type, :image_url
  validates_uniqueness_of :title, scope: [:banner_type, :image_url]
end
