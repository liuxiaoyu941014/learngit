require 'rails_helper'

module Favorite
  RSpec.describe Entry, type: :model do
    it 'attributes' do
      expect(described_class.attribute_names).to match_array(%w(id user_id resource_type resource_id created_at updated_at))
    end

    it { should belong_to :user }
    it { should belong_to :resource }
    it { should validate_presence_of :user }
    it { should validate_presence_of :resource }
  end
end
