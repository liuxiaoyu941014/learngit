require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many :favorites }
  describe 'Product#favorites' do
    subject { create(:product).favorites }
    it { should respond_to :tag_by! }
    it { should respond_to :untag_by! }
    it { should respond_to :tagged_by? }
  end

end
