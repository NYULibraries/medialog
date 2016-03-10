class Api::V0Controller < ApplicationController
  
  def accession 
    mlog_entries = MlogEntry.where("accession_num = ? and collection_code = ?", "2014.279", "mss279")
    render :json => mlog_entries
  end

end
