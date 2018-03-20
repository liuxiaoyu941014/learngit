require 'rails_helper'

RSpec.describe Member, type: :model do

  describe "Create/Update/Destroy" do
    it { expect(described_class::Create).to be_a(Proc) }
    it { expect(described_class::Update).to be_a(Proc) }
    it { expect(described_class::Destroy).to be_a(Proc) }
  end

  it do
    expect(described_class.attribute_names).to match_array(%w(id user_id site_id name gender birth qq email updated_at created_at))
  end

  # it { should have_many(:xxx) }
  it { should belong_to :site }
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :site }
  it { should validate_uniqueness_of(:user_id).scoped_to(:site_id) }
  # it { should have_attr_accessor :xxx }

  describe "Instance" do
    subject { build(:member) }

    it 'is valid with valid attribues' do
      expect(subject).to be_valid
    end

    # it 'is invalid with invalid attribues' do
    #   expect(described_class.new).not_to be_valid
    # end

  end

  it 'is versioned' do
    record = create(:member)
    expect(record.audits.size).to eq(1)
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
