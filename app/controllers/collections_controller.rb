class CollectionsController < ApplicationController
  
  def index
    @collections = Collection.order(updated_at: :desc)
  end

  def show
    @col = Collection.find(params[:id])
    @mlog_entries = MlogEntry.where("collection_id = ?", params[:id]).order(media_id: :asc).page params[:page]
    
  end

  def edit
    @col = Collection.find(params[:id])
  end

  def destroy
    @col = Collection.find(params[:id])
    @col.destroy
    redirect_to :action => "index"
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

  private 
    def collection_params
      params.require(:collection).permit(:title, :collection_code, :partner_code)
    end

end
