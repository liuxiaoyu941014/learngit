require 'rails_helper'

RSpec.describe "cms/keystores/new", type: :view do
  before(:each) do
    assign(:cms_keystore, Cms::Keystore.new(
      :site => nil,
      :key => "MyString",
      :value => "MyString",
      :description => "MyString"
    ))
  end
  it "renders new cms_keystore form" do
    render
    assert_select "form[action=?][method=?]", cms_keystores_path, "post" do

      assert_select "input#cms_keystore_site_id[name=?]", "cms_keystore[site_id]"

      assert_select "input#cms_keystore_key[name=?]", "cms_keystore[key]"

      assert_select "input#cms_keystore_value[name=?]", "cms_keystore[value]"

      assert_select "input#cms_keystore_description[name=?]", "cms_keystore[description]"
    end
  end
end
