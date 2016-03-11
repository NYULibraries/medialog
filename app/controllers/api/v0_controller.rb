class Api::V0Controller < ApplicationController

  def accession 
    mlog_entries = MlogEntry.where("accession_num = ? and collection_code = ?", params["accession_num"], params["collection_code"])
    formats = Hash.new
    
    mlog_entries.each do |entry|
      format =MLOG_VOCAB["mediatypes"][entry["mediatype"]]
      if formats.has_key? format
      	prev = formats[format] 
      	formats[format] = { "qty" => prev["qty"] + 1, "unit" => prev["unit"], "size" => prev["size"] + entry["stock_size"].to_f } 
      else 
      	formats[format] = { "qty" => 1, "unit" => entry["stock_unit"], "size" => entry["stock_size"].to_f }
      end
    end
    
    render :json => {"media_formats" => formats }
  end
end
