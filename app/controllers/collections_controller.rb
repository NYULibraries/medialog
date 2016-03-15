class CollectionsController < ApplicationController
  
  def show
    @collection = Collection.find(params[:id])
    render json: @collection
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
