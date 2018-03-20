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
RSpec.describe Agent::ProductsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:product)
  }
  let(:invalid_attributes) {
    attributes_for(:product)
  }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Agent::ProductsController. Be sure to keep this updated too.

  login_admin
  # login_user
  # login_agent

  describe "GET #index" do
    it "returns a success response" do
      product = create(:product)
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = create(:product)
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
      product = create(:product)
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

      it "redirects to the created agent_product" do
        post :create, params: {product: valid_attributes}
        expect(response).to redirect_to(agent_product_url(Product.last))
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
        skip("Add a hash of attributes valid for your model")
      }
      it "updates the requested agent_product" do
        product = create(:product)
        put :update, params: {id: product.to_param, product: new_attributes}
        product.reload
        skip("Add assertions for updated state")
      end
      it "redirects to the agent_product" do
        product = create(:product)
        put :update, params: {id: product.to_param, product: valid_attributes}
        expect(response).to redirect_to(agent_product_url(product))
      end
    end
    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        product = create(:product)
        put :update, params: {id: product.to_param, product: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested agent_product" do
      product = create(:product)
      expect {
        delete :destroy, params: {id: product.to_param}
      }.to change(Product, :count).by(-1)
    end
    it "redirects to the agent_products list" do
      product = create(:product)
      delete :destroy, params: {id: product.to_param}
      expect(response).to redirect_to(agent_products_url)
    end
  end
end