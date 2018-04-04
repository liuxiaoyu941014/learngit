require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  it 'avatar_image_tag' do
    expect(helper.avatar_image_tag(User.new)).to match '<img'
    expect(helper.avatar_image_tag(User.new, class_name: 'my-class')).to match 'my-class'
  end

  it 'sidebar_link_tag' do
    expect(helper.sidebar_link_tag('title', 'url')).to match 'title'
    expect(helper.sidebar_link_tag('title', 'url', remote: true)).to match 'data-remote'
  end

  it 'simple_form_error_messages' do
    expect(helper).to respond_to :simple_form_error_messages
  end

  it 'render_api_json' do
    expect(helper).to respond_to :render_api_json
  end
end
