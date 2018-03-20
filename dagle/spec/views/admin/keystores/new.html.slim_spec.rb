require 'rails_helper'

RSpec.describe "admin/keystores/new", type: :view do
  before(:each) do
    assign(:keystore, Keystore.new(
      :key => "MyString",
      :value => "MyString",
      :description => "MyString"
    ))
  end
  it "renders new admin_keystore form" do
    render
    assert_select "form[action=?][method=?]", admin_keystores_path, "post" do

      assert_select "input#keystore_key[name=?]", "keystore[key]"

      assert_select "input#keystore_value[name=?]", "keystore[value]"

      assert_select "input#keystore_description[name=?]", "keystore[description]"
    end
  end
end
