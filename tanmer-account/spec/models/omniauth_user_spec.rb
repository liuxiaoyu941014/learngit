require 'rails_helper'

RSpec.describe OmniauthUser, type: :model do
  context "associations" do
    it { should belong_to :user }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end
end
