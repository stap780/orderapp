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

RSpec.describe SskomsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Sskom. As you add validations to Sskom, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SskomsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all sskoms as @sskoms" do
      sskom = Sskom.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:sskoms)).to eq([sskom])
    end
  end

  describe "GET #show" do
    it "assigns the requested sskom as @sskom" do
      sskom = Sskom.create! valid_attributes
      get :show, {:id => sskom.to_param}, valid_session
      expect(assigns(:sskom)).to eq(sskom)
    end
  end

  describe "GET #new" do
    it "assigns a new sskom as @sskom" do
      get :new, {}, valid_session
      expect(assigns(:sskom)).to be_a_new(Sskom)
    end
  end

  describe "GET #edit" do
    it "assigns the requested sskom as @sskom" do
      sskom = Sskom.create! valid_attributes
      get :edit, {:id => sskom.to_param}, valid_session
      expect(assigns(:sskom)).to eq(sskom)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sskom" do
        expect {
          post :create, {:sskom => valid_attributes}, valid_session
        }.to change(Sskom, :count).by(1)
      end

      it "assigns a newly created sskom as @sskom" do
        post :create, {:sskom => valid_attributes}, valid_session
        expect(assigns(:sskom)).to be_a(Sskom)
        expect(assigns(:sskom)).to be_persisted
      end

      it "redirects to the created sskom" do
        post :create, {:sskom => valid_attributes}, valid_session
        expect(response).to redirect_to(Sskom.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved sskom as @sskom" do
        post :create, {:sskom => invalid_attributes}, valid_session
        expect(assigns(:sskom)).to be_a_new(Sskom)
      end

      it "re-renders the 'new' template" do
        post :create, {:sskom => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested sskom" do
        sskom = Sskom.create! valid_attributes
        put :update, {:id => sskom.to_param, :sskom => new_attributes}, valid_session
        sskom.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested sskom as @sskom" do
        sskom = Sskom.create! valid_attributes
        put :update, {:id => sskom.to_param, :sskom => valid_attributes}, valid_session
        expect(assigns(:sskom)).to eq(sskom)
      end

      it "redirects to the sskom" do
        sskom = Sskom.create! valid_attributes
        put :update, {:id => sskom.to_param, :sskom => valid_attributes}, valid_session
        expect(response).to redirect_to(sskom)
      end
    end

    context "with invalid params" do
      it "assigns the sskom as @sskom" do
        sskom = Sskom.create! valid_attributes
        put :update, {:id => sskom.to_param, :sskom => invalid_attributes}, valid_session
        expect(assigns(:sskom)).to eq(sskom)
      end

      it "re-renders the 'edit' template" do
        sskom = Sskom.create! valid_attributes
        put :update, {:id => sskom.to_param, :sskom => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sskom" do
      sskom = Sskom.create! valid_attributes
      expect {
        delete :destroy, {:id => sskom.to_param}, valid_session
      }.to change(Sskom, :count).by(-1)
    end

    it "redirects to the sskoms list" do
      sskom = Sskom.create! valid_attributes
      delete :destroy, {:id => sskom.to_param}, valid_session
      expect(response).to redirect_to(sskoms_url)
    end
  end

end
