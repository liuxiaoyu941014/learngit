module Favorite
  class Entry < ApplicationRecord
    belongs_to :resource, polymorphic: true, counter_cache: :favorites_count
    belongs_to :user
    validates_presence_of :resource, :user
  end
end
