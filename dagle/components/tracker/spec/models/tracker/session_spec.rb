require 'rails_helper'

module Tracker
  RSpec.describe Session, type: :model do
    it 'attributes' do
      expected_attributes = %w(
        id created_at updated_at
      )
      diff = Session.new.attributes.keys + expected_attributes - (Session.new.attributes.keys & expected_attributes)
      expect(diff).to be_empty
    end

    it { should have_many :visits }
  end
end
