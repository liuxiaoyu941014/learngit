class AddressBook < ApplicationRecord
  audited
  belongs_to :user
  store_accessor :features, :full_address, :default_delivery_address
end
