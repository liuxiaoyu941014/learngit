require 'rails_helper'

module Comment
  RSpec.describe Entry, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id user_id resource_type resource_id content position deleted
        created_at updated_at
      )
      expect(described_class.attribute_names).to match_array(expected_attributes)
    end
  end
end
