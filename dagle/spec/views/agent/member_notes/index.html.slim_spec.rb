require 'rails_helper'

RSpec.describe "agent/member_notes/index", type: :view do
  before(:each) do
    assign(:member_notes, [
      MemberNote.new(id: 1,
        :message => "MyText"
      ),
      MemberNote.new(id: 2,
        :message => "MyText"
      )
    ])
  end
  it "renders a list of agent/member_notes" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
