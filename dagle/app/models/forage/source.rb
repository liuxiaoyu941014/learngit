class Forage::Source < ApplicationRecord
  audited
  has_many :run_keys, dependent: :destroy
  validates_uniqueness_of :url
end
