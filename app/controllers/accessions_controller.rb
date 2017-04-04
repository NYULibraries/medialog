class AccessionsController < ApplicationController

  def index
  	@accessions = Accession.all
  end

    def lookup
      puts params
      mlog_entries = lookup_mlog_entry(params['collection_id'], params['media_id'])
      if mlog_entries.size != 0 then 
        redirect_to mlog_entries[0]
      else
        flash[:notice] = "id #{params[:media_id]} does not exist in current collection."
        redirect_to Accession.find(params['accession_id'])
      end
    end

  def show
    @accession = Accession.find(params[:id])
    @collection = Collection.find(@accession.collection_id)
    @mlog = MlogEntry.where("accession_id = ?", @accession.id)
    @mlog_entries = MlogEntry.where("accession_id = ?", @accession.id).order(media_id: :asc).page params[:page]
    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
  end

  def new
  	@collection = Collection.find(params[:collection_id])
  end

  def create
    @accession = Accession.new(accession_params)
    @accession.save
    @collection = Collection.find(@accession.collection_id)
    redirect_to @collection
  end

  def edit
    @accession = Accession.find(params[:id])
    @collection = Collection.find(@accession.collection_id)
  end

  def update
    accession = Accession.find(params[:id])
    accession.update(accession_params)
    redirect_to accession
  end

  def slew
    @accession = Accession.find(params[:id])
    @collection =  Collection.find(@accession.collection_id) 
  end

  def create_slew
  end

  def destroy

    accession = Accession.find(params[:id])
    collection = Collection.find(accession.collection_id)
    mlog_entries = MlogEntry.where("accession_id = ?", accession.id)

    mlog_entries.each do |entry|
      entry.destroy
    end

    accession.destroy

    redirect_to collection

  end

  private 
    def accession_params
      params.require(:accession).permit(:accession_num, :accession_note, :collection_id)
    end
end
