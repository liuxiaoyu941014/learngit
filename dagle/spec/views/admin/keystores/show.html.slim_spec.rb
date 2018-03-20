require 'rails_helper'

RSpec.describe "admin/keystores/show", type: :view do
  before(:each) do
    @keystore = assign(:keystore, Keystore.new(id: 1,
      :key => "Key",
      :value => "Value",
      :description => "Description"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(/Description/)
  end
end
