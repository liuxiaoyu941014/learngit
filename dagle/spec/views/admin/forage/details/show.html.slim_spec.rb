require 'rails_helper'

RSpec.describe "admin/forages/show", type: :view do
  before(:each) do
    @forage_detail = assign(:forage_detail, Forage::Detail.new(id: 1,
      :forage_simple => nil,
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => ""
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
