class Api::V0Controller < ApplicationController
  
  def accession 
    mlog_entries = MlogEntry.where("accession_num = ? and collection_code = ?", params["accession_num"], params["collection_code"])
    render :json => mlog_entries
  end

end
