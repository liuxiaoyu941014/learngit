require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    let(:product) { create :product }
    it "works! (now write some real specs)" do

      get product_path(product)
      expect(response).to have_http_status(200)
    end
  end
end
