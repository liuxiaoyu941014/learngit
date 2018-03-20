require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CmsHelper. For example:
#
# describe CmsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Cms::ApplicationHelper, type: :helper do
  subject { helper }

  it { should respond_to :bg_colors }
  it { expect(subject.bg_colors).to be_a(Array) }

  it { should respond_to :meta_title }
  it { should respond_to :meta_keywords }
  it { should respond_to :meta_description }
  it { should respond_to :cms_content }
  it { should respond_to :get_date }
  it { should respond_to :get_cms_url }
end
