require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.
RSpec.describe Admin::ProductsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:product).merge(site_id: site.id)
  }
  let(:invalid_attributes) {
    attributes_for(:product).merge(price: 'abc')
  }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::ProductsController. Be sure to keep this updated too.

  login_admin
  # login_user
  # login_agent

  let(:agent) { create(:agent) }
  let(:site) { create(:site, user: agent) }

  describe "GET #index" do
    it "returns a success response" do
      product = create(:product, site: site)
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = create(:product, site: site)
      get :show, params: {id: product.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end
  describe "GET #edit" do
    it "returns a success response" do
      product = create(:product, site: site)
      get :edit, params: {id: product.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: {product: valid_attributes}
        }.to change(Product, :count).by(1)
      end

      it "redirects to the created admin_product" do
        post :create, params: {product: valid_attributes}
        expect(response).to redirect_to(admin_product_url(Product.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {product: invalid_attributes}
        expect(response).to be_success
      end
    end
  end
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { price: 1234, name: 'New Name'}
      }
      it "updates the requested admin_product" do
        product = create(:product, site: site)
        put :update, params: {id: product.to_param, product: new_attributes}
        product.reload
        expect(product.price).to eq(new_attributes[:price])
        expect(product.name).to eq(new_attributes[:name])
      end
      it "redirects to the admin_product" do
        product = create(:product, site: site)
        put :update, params: {id: product.to_param, product: valid_attributes}
        expect(response).to redirect_to(admin_product_url(product))
      end
    end
    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        product = create(:product, site: site)
        put :update, params: {id: product.to_param, product: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_product" do
      product = create(:product, site: site)
      expect {
        delete :destroy, params: {id: product.to_param}
      }.to change(Product, :count).by(-1)
    end
    it "redirects to the admin_products list" do
      product = create(:product, site: site)
      delete :destroy, params: {id: product.to_param}
      expect(response).to redirect_to(admin_products_url)
    end
  end
end