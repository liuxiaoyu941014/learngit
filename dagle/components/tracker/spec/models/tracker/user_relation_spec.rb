require 'rails_helper'

module Tracker
  RSpec.describe UserRelation, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id master_id slave_id created_at updated_at
      )
      expect(UserRelation.attribute_names).to match_array(expected_attributes)
    end

    it { should belong_to :master }
    it { should belong_to :slave }
  end
end
