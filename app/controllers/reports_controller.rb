class ReportsController < ApplicationController
  
  def index
    year = params["year"].to_i
    @beginDate = Date.new(year - 1, 9, 1) 
    @endDate =Date.new(year,8,31)
    

    collections = Hash.new
    col = Collection.all.select('id', 'partner_code').as_json
    
    col.each do |c|
      collections[c['id']] = c['partner_code']
    end


    accessions = Hash.new
    accs = Accession.all.select('id','collection_id').as_json
    accs.each do |a|
        accessions[a['id']] = a['collection_id']
    end

    @mlog= MlogEntry.where("created_at >= ? AND created_at <= ?", @beginDate, @endDate)

    @fales = Array.new
    @nyuarchives = Array.new
    @tamwag = Array.new

    @mlog.each do |entry|
        if collections[accessions[entry[:accession_id]]] == "fales" then
            @fales.push entry    
        elsif collections[accessions[entry[:accession_id]]] == "tamwag" then
            @tamwag.push entry
        elsif collections[accessions[entry[:accession_id]]] == "nyuarchives" then
            @nyuarchives.push entry    
        end

    end

    @fales_data = get_type_data(@fales)
    @fales_size = get_total_size(@fales_data)

    @tamwag_data = get_type_data(@tamwag)
    @tamwag_size = get_total_size(@tamwag_data)

    @nyu_data = get_type_data(@nyuarchives)
    @nyu_size = get_total_size(@nyu_data)

    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
    



  
  end

end
