require 'rails_helper'

RSpec.describe "admin/users/new", type: :view do
  before(:each) do
    assign(:user_weixin, User::Weixin.new(
      :user => nil,
      :name => "MyString",
      :headshot => "MyString",
      :city => "MyString",
      :province => "MyString",
      :country => "MyString",
      :gender => 1
    ))
  end
  it "renders new admin_user form" do
    render
    assert_select "form[action=?][method=?]", admin_user_weixins_path, "post" do

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
