require 'rails_helper'

module Tracker
  RSpec.describe Visit, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id session_id user_id action_id resource_type resource_id url
        referer payload user_agent_data ip_address
        created_at updated_at
      )
      diff = Visit.new.attributes.keys + expected_attributes - (Visit.new.attributes.keys & expected_attributes)
      expect(diff).to be_empty
    end

    it { should belong_to :session }
    it { should belong_to :action }
    it { should belong_to :resource }
    it { should validate_presence_of(:url) }
  end
end
