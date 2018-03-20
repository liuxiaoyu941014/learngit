# == Schema Information
#
# Table name: themes
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  config       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe "Create/Update/Destroy" do
    it { expect(described_class::Create).to be_a(Proc) }
    it { expect(described_class::Update).to be_a(Proc) }
    it { expect(described_class::Destroy).to be_a(Proc) }
  end

  describe 'attribtues' do
    subject { described_class.new.attributes }
    it { should include('name') }
    it { should include('display_name') }
    it { should include('created_at') }
    it { should include('updated_at') }
  end

  it { should have_many :theme_configs }
  it { should have_many(:sites).through(:theme_configs) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :display_name }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :display_name }
end

