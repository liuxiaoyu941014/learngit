class Classorder < ApplicationRecord
  audited
  validates_uniqueness_of :name
end
