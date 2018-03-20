class Forage::Detail < ApplicationRecord
  audited
  store_accessor :features, :original_catalog, :district_from

  belongs_to :simple, class_name: '::Forage::Simple'
  validates_uniqueness_of :url, scope: :simple_id

end
