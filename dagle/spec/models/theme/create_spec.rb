require 'rails_helper'

RSpec.describe 'Theme::Create', type: :model do
  it 'with valid attributes' do
    theme = build(:theme)
    flag, new_theme = Theme::Create.(theme.attributes.slice("name", "display_name"))
    expect(flag).to be(true)
    expect(new_theme.name).to eq(theme.name)
    expect(new_theme.display_name).to eq(theme.display_name)
  end

  it 'without name' do
    theme = build(:theme)
    flag, new_theme = Theme::Create.(theme.attributes.slice("display_name"))
    expect(flag).to be(false)
  end

  it 'without display_name' do
    theme = build(:theme)
    flag, new_theme = Theme::Create.(theme.attributes.slice("name"))
    expect(flag).to be(false)
  end

  it 'with existing record' do
    theme = create(:theme)
    flag, new_theme = Theme::Create.(theme.attributes.slice("name", "display_name"))
    expect(flag).to be(false)
  end
end
