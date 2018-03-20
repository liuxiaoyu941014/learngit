require 'rails_helper'

RSpec.describe "admin/cms/edit", type: :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, Cms::Comment.create!(id: 1, ))
  end
  it "renders the edit admin_cm form" do
    render
    assert_select "form[action=?][method=?]", admin_cm_path(@cms_comment), "post" do
    end
  end
end
