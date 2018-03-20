require 'rails_helper'

module Tracker
  RSpec.describe ShareCode, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id user_id resource_type resource_id url created_at updated_at
      )
      expect(ShareCode.attribute_names).to match_array(expected_attributes)
    end

    it { should belong_to :user }
    it { should belong_to :resource }
  end
end
