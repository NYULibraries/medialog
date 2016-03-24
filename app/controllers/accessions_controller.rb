class AccessionsController < ApplicationController

  def index
  	@accessions = Accession.all
  end

  def show
  	@accession = Accession.find(params[:id])
  	@collection = Collection.find(@accession.collection_id)
  	@mlog_entries = MlogEntry.where("accession_num = ? and collection_id = ?", @accession.accession_num, @accession.collection_id).order(media_id: :asc).page params[:page]

  end
end
