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
RSpec.describe Admin::Forage::SourcesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Forage::Source. As you add validations to Forage::Source, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:forage_source)
  }
  let(:invalid_attributes) {
    attributes_for(:forage_source)
  }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::Forage::SourcesController. Be sure to keep this updated too.

  login_admin
  # login_user
  # login_agent

  describe "GET #index" do
    it "returns a success response" do
      forage_source = create(:forage_source)
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      forage_source = create(:forage_source)
      get :show, params: {id: forage_source.to_param}
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
      forage_source = create(:forage_source)
      get :edit, params: {id: forage_source.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Forage::Source" do
        expect {
          post :create, params: {forage_source: valid_attributes}
        }.to change(Forage::Source, :count).by(1)
      end

      it "redirects to the created admin_forage" do
        post :create, params: {forage_source: valid_attributes}
        expect(response).to redirect_to(admin_forage_source_url(Forage::Source.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {forage_source: invalid_attributes}
        expect(response).to be_success
      end
    end
  end
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }
      it "updates the requested admin_forage" do
        forage_source = create(:forage_source)
        put :update, params: {id: forage_source.to_param, forage_source: new_attributes}
        forage_source.reload
        skip("Add assertions for updated state")
      end
      it "redirects to the admin_forage" do
        forage_source = create(:forage_source)
        put :update, params: {id: forage_source.to_param, forage_source: valid_attributes}
        expect(response).to redirect_to(admin_forage_source_url(forage_source))
      end
    end
    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        forage_source = create(:forage_source)
        put :update, params: {id: forage_source.to_param, forage_source: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested admin_forage" do
      forage_source = create(:forage_source)
      expect {
        delete :destroy, params: {id: forage_source.to_param}
      }.to change(Forage::Source, :count).by(-1)
    end
    it "redirects to the admin_forage_sources list" do
      forage_source = create(:forage_source)
      delete :destroy, params: {id: forage_source.to_param}
      expect(response).to redirect_to(admin_forage_sources_url)
    end
  end
end