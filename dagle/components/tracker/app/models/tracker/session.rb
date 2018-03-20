module Tracker
  class Session < ApplicationRecord
    has_many :visits, dependent: :destroy
  end
end
