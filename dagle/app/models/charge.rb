class Charge < ApplicationRecord
  audited
  belongs_to :order
end
