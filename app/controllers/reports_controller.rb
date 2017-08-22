
class ReportsController < ApplicationController
  def index
    year = params["year"].to_i
    @beginDate = Date.new(year - 1, 9, 1) 
    @endDate =Date.new(year,8,31)
    @mlog = MlogEntry.where("created_at >= ? AND created_at <= ?", @beginDate, @endDate)
    @type_data = get_type_data(@mlog)
    @total_size = get_total_size(@type_data)
    puts(@type_data)
  end
end
