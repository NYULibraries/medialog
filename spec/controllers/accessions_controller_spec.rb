require 'rails_helper'

RSpec.describe AccessionsController, type: :controller do
  render_views

  let(:valid_user) { { 
    "email" => "me@home.com", 
    "password" => "watching the telly",
    "admin" => false 
  } }	

  let(:valid_collection_attributes) { { 
    "id" => 55,
    "title" => "test_collection", 
    "partner_code" => "fa",
    "collection_code" => "mssxxx" } }

  let(:valid_accession_attributes) { {
    "id" => 1,
    "accession_num" => "1999.99",
    "collection_id" => 55
  } }

  let(:valid_entry_attributes) { { 
    "collection_id" => 55,
    "mediatype" => "my media", 
    "media_id" => 55,
    "accession_id" => 42
  } }


  let(:valid_session) { {} }


  let(:user) { User.create! valid_user }

  before { sign_in user }

  describe "GET index" do
    it "assigns all accessions as @accessions" do
      accession = Accession.create! valid_accession_attributes
      get :index, {}, valid_session
      expect(assigns(:accessions)).to eq([accession])
    end
  end

  describe "GET show" do
  	it "assigns a accession as @accession" do
  		accession = Accession.create! valid_accession_attributes
  		collection = Collection.create! valid_collection_attributes
  		get :show, { :id => accession.to_param }, valid_session
  		expect(assigns(:accession)).to eq accession
  	end
  end

  describe "PUT update" do
  	describe "with valid attributes" do
  		it "updates the requested acccesion" do
  			accession = Accession.create! valid_accession_attributes
  			collection = Collection.create! valid_collection_attributes
  			allow_any_instance_of(Accession).to receive(:update).with({ "accession_num" => "XXX.XXX.XXX.XXX" })
        put :update, {:id => accession.to_param, :accession => { "accession_num" => "XXX.XXX.XXX.XXX" }}, valid_session
  		end

  		it "redirects to the accession" do
        Collection.create! valid_collection_attributes
        accession = Accession.create! valid_accession_attributes
        put :update, {:id => accession.to_param, :accession => valid_accession_attributes}, valid_session
        expect(response).to redirect_to(accession)
      end
  	end
  end

  describe "DELETE destroy" do
  	it "destroys the requested accession" do
  		accession = Accession.create! valid_accession_attributes
  		collection = Collection.create! valid_collection_attributes	
  		expect {
        delete :destroy, {:id => accession.to_param}, valid_session
      }.to change(Accession, :count).by(-1)
  	end

  	it "should redirect to collection record" do
  		accession = Accession.create! valid_accession_attributes
  		collection = Collection.create! valid_collection_attributes
  		delete :destroy, { :id => accession.to_param }, valid_session
  		expect(response).to redirect_to(collection)
  	end
  end
end