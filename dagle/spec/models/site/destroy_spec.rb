require 'rails_helper'

RSpec.describe 'Site::Destroy', type: :model do
  let(:user) { create(:user) }
  it do
    site = create(:site, user: user)
    Site::Destroy.(site)
    expect(Site.exists?(site.id)).to eq(false)
  end
end
