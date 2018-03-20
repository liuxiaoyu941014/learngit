class Forage::Simple < ApplicationRecord
  audited

  store_accessor :features, :district_from, :original_catalog
  belongs_to :run_key, class_name: '::Forage::RunKey'

  store_accessor :features, :original_catalog, :district_from
  has_many :details, dependent: :destroy
  validates_uniqueness_of :url, scope: :run_key_id
end
