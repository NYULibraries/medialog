class ReportsController < ApplicationController
  def index

  end

  def format
  	@types = MLOG_VOCAB["mediatypes"]
  end

  def type
  	@types = MLOG_VOCAB["mediatypes"]
    @type = params[:type]
    @entries = MlogEntry.where("mediatype = ?", @type).order(:partner_code, :collection_code)
    @entries_size = MlogEntry.select("image_size_bytes")
  
    @sum = 0.0
    @entries.each do |entry|
      if(entry.stock_unit == 'MB') then
        @sum = @sum + mb_to_byte(entry.stock_size_num)
      elsif (entry.stock_unit == 'GB') then
        @sum = @sum + gb_to_byte(entry.stock_size_num)  
      end
    end

    @sum = human_size(@sum)

    @image_sum = 0.0
    @entries.each do |entry|
      if(entry.image_size_bytes != nil) then
        @image_sum = @image_sum + entry.image_size_bytes
      end
    end
    @image_sum = human_size(@image_sum)

  end
end
