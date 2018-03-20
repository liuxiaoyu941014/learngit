require 'rails_helper'

RSpec.describe "Cms::Comments", type: :request do
  describe "GET /cms_comments" do
    it "works! (now write some real specs)" do
      get cms_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
