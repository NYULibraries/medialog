class CollectionsController < ApplicationController
  
  def index
    @collections = Collection.order(updated_at: :desc)
  end

  def repository

    @collections = Collection.where("partner_code = ?", params[:repository_code]).order(collection_code: :asc)
    @sizes = get_sizes(@collections)
    @summaries = get_collection_summaries(@sizes)
 
  end

  def show
    @collection = Collection.find(params[:id])
    @accessions = Accession.where("collection_id = ?", @collection.id)
    @min_accessions = getMinAccessions
    @mlog_entries = MlogEntry.where("collection_id = ?", @collection.id).order(media_id: :asc).page params[:page]
    @summaries = get_summaries(@mlog_entries)
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

    class Repository_Coll
      attr_accessor :stock_size, :image_size 

      def initialize(stock_size, image_size)
        @stock_size = stock_size
        @image_size = image_size
      end
    end

    def get_collection_summaries(sizes)
      summaries = Hash.new
      stock = 0.0
      image = 0.0

      sizes.each do |size|
        stock = stock + size[1].stock_size
        image = image + size[1].image_size
      end
         
      summaries["stock_size"] = stock
      summaries["image_size"] = image

      summaries

    end

    def get_sizes(collections)
    
      collection_sizes = Hash.new

      collections.each do |collection|
        entries = MlogEntry.where(["collection_id = ?", collection.id])
        entries.each do |entry|
          stock_size = 0.0
          image_size = 0.0

          if entry.image_size_bytes != nil then
            image_size = entry.image_size_bytes
          end

          if entry.stock_size != nil then
            if(entry.stock_unit == 'KB') then
              stock_size = kb_to_byte(entry.stock_size_num)
            elsif(entry.stock_unit == 'MB') then
              stock_size = mb_to_byte(entry.stock_size_num)
            elsif (entry.stock_unit == 'GB') then
              stock_size = gb_to_byte(entry.stock_size_num)
            elsif(entry.stock_unit == 'TB') then
              stock_size = tb_to_byte(entry.stock_size_num)
            end
          end

          if !collection_sizes.include? entry.collection_id then
            collection_sizes[collection.id] = Repository_Coll.new(stock_size, image_size)
          else 
            new_collection = collection_sizes[collection.id]
            new_image_size  = new_collection.image_size + image_size
            new_stock_size = new_collection.stock_size + stock_size
            collection_sizes[collection.id] = Repository_Coll.new(new_stock_size, new_image_size)
          end

        end
      end
      return collection_sizes
    end


    
end
