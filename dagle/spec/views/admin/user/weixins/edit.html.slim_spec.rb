require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do
  before(:each) do
    @user_weixin = assign(:user_weixin, User::Weixin.create!(id: 1, 
      :user => nil,
      :name => "MyString",
      :headshot => "MyString",
      :city => "MyString",
      :province => "MyString",
      :country => "MyString",
      :gender => 1
    ))
  end
  it "renders the edit admin_user form" do
    render
    assert_select "form[action=?][method=?]", admin_user_path(@user_weixin), "post" do

      assert_select "input#user_weixin_user_id[name=?]", "user_weixin[user_id]"

      assert_select "input#user_weixin_name[name=?]", "user_weixin[name]"

      assert_select "input#user_weixin_headshot[name=?]", "user_weixin[headshot]"

      assert_select "input#user_weixin_city[name=?]", "user_weixin[city]"

      assert_select "input#user_weixin_province[name=?]", "user_weixin[province]"

      assert_select "input#user_weixin_country[name=?]", "user_weixin[country]"

      assert_select "input#user_weixin_gender[name=?]", "user_weixin[gender]"
    end
  end
end
