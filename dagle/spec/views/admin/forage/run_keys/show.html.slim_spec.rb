require 'rails_helper'

RSpec.describe "admin/forages/show", type: :view do
  before(:each) do
    @forage_run_key = assign(:forage_run_key, Forage::RunKey.new(id: 1,
      :source => nil,
      :date => "Date"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Date/)
  end
end
