require 'rails_helper'

RSpec.describe "agent/member_notes/new", type: :view do
  before(:each) do
    assign(:member_note, MemberNote.new(
      :message => "MyText"
    ))
  end
  it "renders new agent_member_note form" do
    render
    assert_select "form[action=?][method=?]", agent_member_notes_path, "post" do

      assert_select "textarea#member_note_message[name=?]", "member_note[message]"
    end
  end
end
