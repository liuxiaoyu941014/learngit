require 'rails_helper'

RSpec.describe "admin/forages/show", type: :view do
  before(:each) do
    @forage_source = assign(:forage_source, Forage::Source.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
