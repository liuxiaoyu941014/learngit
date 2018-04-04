require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
