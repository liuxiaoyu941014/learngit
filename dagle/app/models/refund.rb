class Refund < ApplicationRecord
  audited
  belongs_to :order
end
