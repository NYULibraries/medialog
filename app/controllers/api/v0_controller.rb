class Api::V0Controller < ApplicationController

  def accession 
    mlog_entries = MlogEntry.where("accession_id = ?", params["id"])
    accession =  Accession.find(params["id"])
    formats = Hash.new
    entries = Hash.new
    
    mlog_entries.each do |entry|
      entries[entry.id] = entry.media_id
      format =MLOG_VOCAB["mediatypes"][entry["mediatype"]]
      if formats.has_key? format
      	prev = formats[format] 
      	formats[format] = { "qty" => prev["qty"] + 1, "unit" => prev["unit"], "size" => prev["size"] + entry["stock_size"].to_f } 
      else 
      	formats[format] = { "qty" => 1, "unit" => entry["stock_unit"], "size" => entry["stock_size"].to_f }
      end
    end
    
    render :json => {"media_formats" => formats, "inventory" => entries }
  end

  def mlog_entry
    render :json => MlogEntry.find(params["id"])
  end
end
