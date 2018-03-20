require 'rails_helper'

RSpec.describe "agent/member_notes/edit", type: :view do
  before(:each) do
    @member_note = assign(:member_note, MemberNote.create!(id: 1, 
      :message => "MyText"
    ))
  end
  it "renders the edit agent_member_note form" do
    render
    assert_select "form[action=?][method=?]", agent_member_note_path(@member_note), "post" do

      assert_select "textarea#member_note_message[name=?]", "member_note[message]"
    end
  end
end
