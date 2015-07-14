module MlogEntriesHelper
  
  class Repository_Coll
    
    attr_accessor :name, :stock_size, :image_size

    def initialize(name, stock_size, image_size)
      @name = name
      @stock_size = stock_size
      @image_size = image_size
    end

  end

  def get_sizes(entries)
    colls = Hash.new

    entries.each do |entry|
      col_title = MLOG_VOCAB["collection_codes"][entry.collection_code].split(" :: ")[1]
      stock_size = 0.0
      image_size = 0.0

      if entry.image_size_bytes != nil then
        image_size = entry.image_size_bytes
      end

      if entry.stock_size != nil then
        if(entry.stock_unit == 'MB') then
          stock_size = mb_to_byte(entry.stock_size_num)
        elsif (entry.stock_unit == 'GB') then
          stock_size = gb_to_byte(entry.stock_size_num)
        elsif(entry.stock_unit == 'TB') then
          stock_size = tb_to_byte(entry.stock_size_num)
        end
      end

      if !colls.include? entry.collection_code then
        colls[entry.collection_code.to_sym] = Repository_Coll.new(col_title, stock_size, image_size)
      else 
        coll = colls[entry.collection_code]
        new_image_size  = coll.image_size + image_size
        new_stock_size = coll.stock_size + stock_size
        colls[entry.collection_code.to_sym] = Repository_Coll.new(col_title, stock_size, new_image_size)
      end
    end

    return colls

  end

end
