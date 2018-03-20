require 'rails_helper'

RSpec.describe "agent/member_notes/show", type: :view do
  before(:each) do
    @member_note = assign(:member_note, MemberNote.new(id: 1,
      :message => "MyText"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
