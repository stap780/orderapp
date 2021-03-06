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

RSpec.describe CitilinksController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Citilink. As you add validations to Citilink, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CitilinksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all citilinks as @citilinks" do
      citilink = Citilink.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:citilinks)).to eq([citilink])
    end
  end

  describe "GET #show" do
    it "assigns the requested citilink as @citilink" do
      citilink = Citilink.create! valid_attributes
      get :show, {:id => citilink.to_param}, valid_session
      expect(assigns(:citilink)).to eq(citilink)
    end
  end

  describe "GET #new" do
    it "assigns a new citilink as @citilink" do
      get :new, {}, valid_session
      expect(assigns(:citilink)).to be_a_new(Citilink)
    end
  end

  describe "GET #edit" do
    it "assigns the requested citilink as @citilink" do
      citilink = Citilink.create! valid_attributes
      get :edit, {:id => citilink.to_param}, valid_session
      expect(assigns(:citilink)).to eq(citilink)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Citilink" do
        expect {
          post :create, {:citilink => valid_attributes}, valid_session
        }.to change(Citilink, :count).by(1)
      end

      it "assigns a newly created citilink as @citilink" do
        post :create, {:citilink => valid_attributes}, valid_session
        expect(assigns(:citilink)).to be_a(Citilink)
        expect(assigns(:citilink)).to be_persisted
      end

      it "redirects to the created citilink" do
        post :create, {:citilink => valid_attributes}, valid_session
        expect(response).to redirect_to(Citilink.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved citilink as @citilink" do
        post :create, {:citilink => invalid_attributes}, valid_session
        expect(assigns(:citilink)).to be_a_new(Citilink)
      end

      it "re-renders the 'new' template" do
        post :create, {:citilink => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested citilink" do
        citilink = Citilink.create! valid_attributes
        put :update, {:id => citilink.to_param, :citilink => new_attributes}, valid_session
        citilink.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested citilink as @citilink" do
        citilink = Citilink.create! valid_attributes
        put :update, {:id => citilink.to_param, :citilink => valid_attributes}, valid_session
        expect(assigns(:citilink)).to eq(citilink)
      end

      it "redirects to the citilink" do
        citilink = Citilink.create! valid_attributes
        put :update, {:id => citilink.to_param, :citilink => valid_attributes}, valid_session
        expect(response).to redirect_to(citilink)
      end
    end

    context "with invalid params" do
      it "assigns the citilink as @citilink" do
        citilink = Citilink.create! valid_attributes
        put :update, {:id => citilink.to_param, :citilink => invalid_attributes}, valid_session
        expect(assigns(:citilink)).to eq(citilink)
      end

      it "re-renders the 'edit' template" do
        citilink = Citilink.create! valid_attributes
        put :update, {:id => citilink.to_param, :citilink => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested citilink" do
      citilink = Citilink.create! valid_attributes
      expect {
        delete :destroy, {:id => citilink.to_param}, valid_session
      }.to change(Citilink, :count).by(-1)
    end

    it "redirects to the citilinks list" do
      citilink = Citilink.create! valid_attributes
      delete :destroy, {:id => citilink.to_param}, valid_session
      expect(response).to redirect_to(citilinks_url)
    end
  end

end
