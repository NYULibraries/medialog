require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  
  render_views

  let(:valid_user) { { 
    "email" => "me@home.com", 
    "password" => "watching the telly",
    "admin" => false } }	

  let(:valid_col_attributes) { { 
    "id" => 55,
    "title" => "test_collection", 
    "partner_code" => "fa",
    "collection_code" => "mssxxx" } }

    let(:valid_accession_attributes) { {
    "id" => 1,
    "accession_num" => "1999.99",
    "collection_id" => 55
  } }

  let(:valid_session) { {} }
  
  valid_collection_table = {55=>{:title=>"test_collection", :collection_code=>"mssxxx", :partner_code=>"fa", :count=>0, :extent=>"0.0 B"}}
  

  let(:user) { User.create! valid_user }

  before { sign_in user }

  describe "GET index" do
    it "assigns all collections as @collections" do
      col = Collection.create! valid_col_attributes
      get :index, {}, valid_session
      expect(assigns(:collections)).to eq(valid_collection_table)
    end
  end

  describe "GET repository" do
    it "displays all collections as a repository" do
      collection = Collection.create! valid_col_attributes
      get :repository, {:repository_code => "fa"}, valid_session
      expect(assigns(:collections)).to eq([collection])
    end
  end

  describe "GET show" do
    it "assigns the requested collection as @collection" do
      collection = Collection.create! valid_col_attributes
      get :show, {:id => collection.to_param}, valid_session
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested mlog_entry" do
        collection = Collection.create! valid_col_attributes
        allow_any_instance_of(Collection).to receive(:update).with({ "collection_code" => "mssXXX" })
        put :update, {:id => collection.to_param, :collection => { "collection_code" => "mssXXX" }}, valid_session
      end

      it ("redirects to collection") do
        collection = Collection.create! valid_col_attributes
        put :update, {:id => collection.to_param, :collection => { "collection_code" => "mssXXX" }}, valid_session
        expect(response).to redirect_to(collection)
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested collection record" do
      collection = Collection.create! valid_col_attributes
      expect {
        delete :destroy, {:id => collection.to_param}, valid_session
      }.to change(Collection, :count).by(-1)
      #response.should redirect_to(:controller => "collections", :action => "repository", :repository_code => collection.partner_code)
    end

    it "should redirect to collections" do
      collection = Collection.create! valid_col_attributes
      delete :destroy, { :id =>  collection.to_param }, valid_session
      expect(response).to redirect_to(:action => "repository", :repository_code => collection.partner_code)
    end
  end
  
end
