require 'rails_helper'

RSpec.describe "admin/keystores/edit", type: :view do
  before(:each) do
    @keystore = assign(:keystore, Keystore.create!(id: 1, 
      :key => "MyString",
      :value => "MyString",
      :description => "MyString"
    ))
  end
  it "renders the edit admin_keystore form" do
    render
    assert_select "form[action=?][method=?]", admin_keystore_path(@keystore), "post" do

      assert_select "input#keystore_key[name=?]", "keystore[key]"

      assert_select "input#keystore_value[name=?]", "keystore[value]"

      assert_select "input#keystore_description[name=?]", "keystore[description]"
    end
  end
end
