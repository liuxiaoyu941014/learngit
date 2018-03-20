require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :favorites }
  describe 'User#favorites' do
    subject { create(:user).favorites }
    it { should respond_to :tag_to! }
    it { should respond_to :untag_to! }
    it { should respond_to :tagged_to? }
  end
end
