require 'rails_helper'

module Tracker
  RSpec.describe Action, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id name controller_path action_name
        created_at updated_at
      )
      diff = Action.new.attributes.keys + expected_attributes - (Action.new.attributes.keys & expected_attributes)
      expect(diff).to be_empty
    end

    it { should validate_uniqueness_of(:action_name).scoped_to(:controller_path) }
    it { should validate_presence_of(:controller_path) }
    it { should validate_presence_of(:action_name) }
    it { should have_many(:visits) }
  end
end
