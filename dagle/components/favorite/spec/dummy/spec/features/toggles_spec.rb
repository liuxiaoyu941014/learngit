require 'rails_helper'

RSpec.feature "Toggles", type: :feature, js: true do
  let(:user) { create :user, id: 1 }
  let(:product){ create :product, id: 1 }
  before(:each) do
    page.set_rack_session(user: user.id)
  end
  it 'tag favorite' do
    user.favorites.untag_to! product
    visit product_path(product)
    expect(page).to have_content '收藏'
    click_button '收藏'
    sleep 1
    expect(user.favorites.tagged_to?(product)).to eq(true)
    expect(page).to have_content '取消收藏'
  end

  it 'untag favorite' do
    user.favorites.tag_to! product
    visit product_path(product)
    click_button '取消收藏'
    sleep 1
    expect(user.favorites.tagged_to?(product)).to eq(false)
    expect(page).to have_content '收藏'
  end
end
