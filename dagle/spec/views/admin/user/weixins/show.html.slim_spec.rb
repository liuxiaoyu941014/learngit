require 'rails_helper'

RSpec.describe "admin/users/show", type: :view do
  before(:each) do
    @user_weixin = assign(:user_weixin, User::Weixin.new(id: 1,
      :user => nil,
      :name => "Name",
      :headshot => "Headshot",
      :city => "City",
      :province => "Province",
      :country => "Country",
      :gender => 2
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Headshot/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Province/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/2/)
  end
end
