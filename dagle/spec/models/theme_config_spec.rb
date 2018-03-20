# == Schema Information
#
# Table name: theme_configs
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  theme_id   :integer
#  config     :text
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ThemeConfig, type: :model do
  describe "Create/Update/Destroy" do
    it { expect(described_class::Create).to be_a(Proc) }
    it { expect(described_class::Update).to be_a(Proc) }
    it { expect(described_class::Destroy).to be_a(Proc) }
  end

  it { should belong_to :site }
  it { should belong_to :theme }

  describe do
    let(:user) { create(:user) }
    let(:site) { create(:site, user: user) }
    let(:theme) { create(:theme) }
    subject { create(:theme_config, site: site, theme: theme) }
    it { should validate_uniqueness_of(:theme_id).scoped_to(:site_id) }
  end
end
