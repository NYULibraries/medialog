class ReportsController < ApplicationController
  
  def index
    @mlog= MlogEntry.all
    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
    @type_data.sort_by { |count| count }

  end

  def year
    year = params[:id].to_i
    @beginDate = Date.new(year, 1, 1)
    @endDate =Date.new(year,12,31)

    @mlog= MlogEntry.where("created_at >= ? AND created_at < ?", @beginDate, @endDate)

    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
  
  end

  def repository 
    @repository = params[:id]
    @accessions = Array.new

    @collections = Collection
        .joins("INNER JOIN accessions ON accessions.collection_id = collections.id")
        .where("partner_code = ?", @repository) 
        .select("accessions.id")

    @collections.each do |collection|
        if(!@accessions.include? collection[:id]) then
            @accessions.push collection[:id]
        end
    end

    year = params[:ay].to_i
    @beginDate = Date.new(year, 1, 1) 
    @endDate =Date.new(year,12,31)

    @mlog = MlogEntry
        .where(accession_id: @accessions)
        .where("created_at >= ? AND created_at <= ?", @beginDate, @endDate)

    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)

  end

end
