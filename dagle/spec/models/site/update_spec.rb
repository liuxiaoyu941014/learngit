require 'rails_helper'

RSpec.describe 'Site::Update', type: :model do
  let(:user) { create(:user) }
  it 'for title' do
    site = create(:site, user: user)
    flag, new_site = Site::Update.(site, title: 'new title')
    expect(flag).to eq(true)
    expect(new_site.title).to eq(site.title)
  end

  it 'for description' do
    site = create(:site, user: user)
    flag, new_site = Site::Update.(site, description: 'new description')
    expect(flag).to eq(true)
    expect(new_site.description).to eq(site.description)
  end

  it 'with existing record' do
    site = create(:site, user: user)
    site2 = create(:site2, user: user)
    flag, _ = Site::Update.(site, site2.attributes.slice('title', 'description'))
    expect(flag).to eq(false)
  end
end
