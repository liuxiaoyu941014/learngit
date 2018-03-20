module Like
  class Base < ApplicationRecord
    self.table_name = 'likes'
    belongs_to :user
    belongs_to :resource, polymorphic: true, counter_cache: :likes_count
    validates_presence_of :resource, :user
  end
end
