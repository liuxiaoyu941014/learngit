module Tracker
  class Visit < ApplicationRecord
    store_accessor :user_agent_data, :user_agent, :browser_name, :platform
    belongs_to :session
    belongs_to :action
    belongs_to :resource, polymorphic: true, optional: true, counter_cache: :visits_count
    validates_presence_of :url

    def self.visits(page: 1)
      visits = Tracker::Visit.all.order(created_at: :desc).page(page)
      return {total_pages: visits.total_pages, selected_page: page, visits: visits}
    end
  end
end
