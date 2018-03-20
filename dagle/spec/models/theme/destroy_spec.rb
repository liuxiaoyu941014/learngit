require 'rails_helper'

RSpec.describe 'Theme::Destroy', type: :model do
  it 'success' do
    theme = create(:theme)
    Theme::Destroy.(theme)
    expect(Theme.exists?(theme.id)).to be(false)
  end
end
