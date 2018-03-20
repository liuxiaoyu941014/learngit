# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Site, type: :model do

  describe "Create/Update/Destroy" do
    it { expect(described_class::Create).to be_a(Proc) }
    it { expect(described_class::Update).to be_a(Proc) }
    it { expect(described_class::Destroy).to be_a(Proc) }
  end

  it do
    expect(Site.attribute_names).to match_array(%w(id user_id title features updated_at created_at))
  end

  it { should have_many(:theme_configs) }
  it { should have_one(:active_theme_config) }
  it { should belong_to :user }
  it { should have_many :items }
  it { should have_many :image_items }
  it { should have_many :members }
  it { should validate_presence_of :title }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of(:title).scoped_to(:user_id) }

  it { should have_attr_accessor :description }

  let(:user) { create(:user) }
  subject { build(:site, user: user) }

  it 'is valid with valid attribues' do
    expect(subject).to be_valid
  end

  it 'is invalid with invalid attribues' do
    expect(Site.new).not_to be_valid
  end
end
