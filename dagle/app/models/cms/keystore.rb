class Cms::Keystore < ApplicationRecord
  audited
  belongs_to :site, class_name: '::Cms::Site'
  validates_presence_of :key, :value
  validates_uniqueness_of :key, scope: [:site_id]

  #methods is in cms/site.rb
end
