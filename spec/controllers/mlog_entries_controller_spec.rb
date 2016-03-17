require 'rails_helper.rb'

describe MlogEntriesController do

  render_views

  # This should return the minimal set of attributes required to create a valid
  # MlogEntry. As you add validations to MlogEntry, be sure to
  # adjust the attributes here as well.


  let(:valid_user) { { 
    "email" => "me@home.com", 
    "password" => "watching the telly",
    "admin" => false } }
  
  let(:valid_entry_attributes) { { 
    "collection_id" => 55,
    "mediatype" => "my media", 
    "media_id" => 55,
    "accession_num" => "0000" } }

  let(:valid_col_attributes) { { 
    "id" => 55,
    "title" => "test_collection", 
    "partner_code" => "fa",
    "collection_code" => "mssxxx" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MlogEntriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  let(:user) { User.create! valid_user }

  before { sign_in user }


  describe "GET index" do
    it "assigns all mlog_entries as @mlog_entries" do
      mlog_entry = MlogEntry.create! valid_entry_attributes
      get :index, {}, valid_session
      assigns(:mlog_entries).should eq([mlog_entry])
    end
  end

  describe "GET show" do
    it "assigns the requested mlog_entry as @mlog_entry" do
      mlog_entry = MlogEntry.create! valid_entry_attributes
      col = Collection.create! valid_col_attributes
      get :show, {:id => mlog_entry.to_param}, valid_session
      assigns(:mlog_entry).should eq(mlog_entry)
    end
  end

  describe "GET new" do
    it "assigns a new mlog_entry as @mlog_entry" do
      col = Collection.create! valid_col_attributes
      get :new, {:id => col.id}, valid_session
      assigns(:mlog_entry).should be_a_new(MlogEntry)
    end
  end

  describe "GET edit" do
    it "assigns the requested mlog_entry as @mlog_entry" do
      col = Collection.create! valid_col_attributes
      mlog_entry = MlogEntry.create! valid_entry_attributes
      get :edit, {:id => mlog_entry.to_param}, valid_session
      assigns(:mlog_entry).should eq(mlog_entry)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "creates a new MlogEntry" do
        col = Collection.create! valid_col_attributes
        expect {
          post :create, {:mlog_entry => valid_entry_attributes}, valid_session
        }.to change(MlogEntry, :count).by(1)
      end

      it "assigns a newly created mlog_entry as @mlog_entry" do
        col = Collection.create! valid_col_attributes
        post :create, {:mlog_entry => valid_entry_attributes}, valid_session
        assigns(:mlog_entry).should be_a(MlogEntry)
        assigns(:mlog_entry).should be_persisted
      end

      it "redirects to the collection of the created mlog_entry" do
        col = Collection.create! valid_col_attributes
        post :create, {:mlog_entry => valid_entry_attributes}, valid_session
        response.should redirect_to(Collection.last)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested mlog_entry" do
        col = Collection.create! valid_col_attributes
        mlog_entry = MlogEntry.create! valid_entry_attributes
        # Assuming there are no other mlog_entries in the database, this
        # specifies that the MlogEntry created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        MlogEntry.any_instance.should_receive(:update).with({ "mediatype" => "" })
        put :update, {:id => mlog_entry.to_param, :mlog_entry => { "mediatype" => "" }}, valid_session
      end

      it "assigns the requested mlog_entry as @mlog_entry" do
        col = Collection.create! valid_col_attributes
        mlog_entry = MlogEntry.create! valid_entry_attributes
        put :update, {:id => mlog_entry.to_param, :mlog_entry => valid_entry_attributes}, valid_session
        assigns(:mlog_entry).should eq(mlog_entry)
      end

      it "redirects to the mlog_entry" do
        col = Collection.create! valid_col_attributes
        mlog_entry = MlogEntry.create! valid_entry_attributes
        put :update, {:id => mlog_entry.to_param, :mlog_entry => valid_entry_attributes}, valid_session
        response.should redirect_to(col)
      end
    end

    describe "with invalid params" do
      it "assigns the mlog_entry as @mlog_entry" do
        col = Collection.create! valid_col_attributes
        mlog_entry = MlogEntry.create! valid_entry_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MlogEntry.any_instance.stub(:save).and_return(false)
        put :update, {:id => mlog_entry.to_param, :mlog_entry => { "partner_code" => "invalid value" }}, valid_session
        assigns(:mlog_entry).should eq(mlog_entry)
      end
    end  
  end

  describe "DELETE destroy" do
  
    it "destroys the requested mlog_entry" do
      col = Collection.create! valid_col_attributes
      mlog_entry = MlogEntry.create! valid_entry_attributes
      expect {
        delete :destroy, {:id => mlog_entry.to_param}, valid_session
      }.to change(MlogEntry, :count).by(-1)
    end

    it "redirects to the mlog_entries list" do
      col = Collection.create! valid_col_attributes
      mlog_entry = MlogEntry.create! valid_entry_attributes
      delete :destroy, {:id => mlog_entry.to_param}, valid_session
      response.should redirect_to(mlog_entries_url)
    end

  end

end
