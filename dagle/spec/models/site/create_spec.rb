require 'rails_helper'

RSpec.describe 'Site::Create', type: :model do
  let(:user) { create(:user) }
  it 'with valid attributes' do
    attrs = attributes_for(:site).slice(:title, :description)
    attrs.update user_id: user.id
    flag, site = Site::Create.(attrs)
    expect(flag).to eq(true)
    expect(site.title).to eq(attrs[:title])
    expect(site.description).to eq(attrs[:description])
  end

  it 'without title' do
    attrs = attributes_for(:site).slice(:description)
    attrs.update user_id: user.id
    flag, _ = Site::Create.(attrs)
    expect(flag).to eq(false)
  end

  describe do
    let(:site) { create(:site, user: user) }
    it 'with existing record' do
      site = create(:site, user: user)
      flag, _ = Site::Create.(site.attributes.slice(:title, :description))
      expect(flag).to eq(false)
    end  
  end
  
end
