class Api::V0Controller < ApplicationController

  def accession 
    mlog_entries = MlogEntry.where("accession_id = ?", params["id"])
    accession =  Accession.find(params["id"])
    collection = Collection.find(accession.collection_id)
    stuff = getTypes(mlog_entries)
    render :json => {"accession" => accession, "collection" => collection, "media_formats" => stuff["formats"], "inventory" => stuff["entries"] }
  end

  def mlog_entry
    render :json => MlogEntry.find(params["id"])
  end

  def collections
    collections = Collection.select(:id).order(:id)
    coll_array = Array.new
    collections.each do |coll|
      coll_array << coll.id
    end
    render :json => coll_array
  end

  def collection
    collection = Collection.find(params["id"])
    accession_recs = Accession.where("collection_id = ?", collection.id)
    stuff = getTypes(MlogEntry.where("collection_id = ?", collection.id))

    formats = getFormats(stuff["formats"])
    totals = getTotals(formats)
    accessions = Hash.new
    accession_recs.each do |accession|
      accessions[accession.id] = accession.accession_num
    end
    render :json => {"collection" => collection, "acccessions" => accessions, :totals => totals, "media_formats" => formats, "objects" => stuff["entries"]}
  end

  def collection_find 
    collection = Collection.where(:collection_code => params[:code])
    render :json => collection
  end

  private
    def getTypes(mlog_entries)
      entries = Hash.new
      formats = Hash.new
      stuff = Hash.new
      mlog_entries.each do |entry|
        entries[entry.id] = { :media_id => entry.media_id, :is_transferred =>  entry.is_transferred, :is_refreshed => entry.is_refreshed }
        format = MLOG_VOCAB["mediatypes"][entry["mediatype"]]
        if formats.has_key? format
          prev = formats[format]
          formats[format] = { "count" => prev["count"] + 1, "size" => prev["size"] + get_in_bytes(entry["stock_size_num"], entry["stock_unit"]).to_f }
        else 
          formats[format] = { "count" => 1, "size" => get_in_bytes(entry["stock_size_num"], entry["stock_unit"]).to_f }
        end
      end
      stuff["entries"] = entries
      stuff["formats"] = formats
      stuff
    end

  def getFormats(fmts)
    formats = Hash.new

    fmts.each do |fmt, value|
      formats[fmt] = { "count" => value["count"], "size_gb" => display_in_gigabytes(value["size"]) }
    end

    formats
  end

  def getTotals(fmts)

    count = 0
    size = 0.0

    fmts.each do |fmt, value|
      count = count + value["count"]
      size = size + value["size_gb"]
    end

    { :num_objects => count, :size_gb => size.round(2) }
  end

end
