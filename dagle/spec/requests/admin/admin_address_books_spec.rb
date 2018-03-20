require 'rails_helper'

RSpec.describe "Admin::AddressBooks", type: :request do
  describe "GET /admin_address_books" do
    it "works! (now write some real specs)" do
      get admin_address_books_path
      expect(response).to have_http_status(200)
    end
  end
end
