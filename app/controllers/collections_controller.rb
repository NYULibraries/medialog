class CollectionsController < ApplicationController
  
  def index
    @collections = Collection.order(updated_at: :desc)
  end

  def lookup
    mlog_entries = lookup_mlog_entry(params['collection_id'], params['media_id'])
    if mlog_entries.size != 0 then 
      redirect_to mlog_entries[0]
    else
      flash[:notice] = "id #{params[:media_id]} does not exist in current collection."
      redirect_to Collection.find(params['collection_id'])
    end
  end

  def repository

    @cols = Collection.where("partner_code = ?", params[:repository_code])
    @collections = @cols.order(collection_code: :asc)


  end

  def show
    @collection = Collection.find(params[:id])
    @accessions = Accession.where("collection_id = ?", @collection.id)
    @min_accessions = getMinAccessions
    @mlog = MlogEntry.where("collection_id = ?", @collection.id)
    @mlog_entries = @mlog.order(media_id: :asc).page params[:page]
    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
  end

  def edit
    @col = Collection.find(params[:id])
  end

  def destroy

    col = Collection.find(params[:id])
    mlog_entries = MlogEntry.where("collection_id = ?", col.id)
  
    mlog_entries.each do |entry|
      entry.destroy
    end
  
    col.destroy
    redirect_to :controller => "collections", :action => "repository", :repository_code => col.partner_code
  end

  def update
    @col = Collection.find(params[:id])
    @col.update(collection_params)
    redirect_to @col
  end

  def new 
  end

  def create 
    @collection = Collection.new(collection_params)
    @collection.save
    redirect_to @collection
  end

  def uuids
    @collection = Collection.find(params[:id])
    @mlog_entries = MlogEntry.where("collection_id = ?", params[:id]).order(media_id: :asc)
  end

  private 
    def collection_params
      params.require(:collection).permit(:title, :collection_code, :partner_code)
    end


end
