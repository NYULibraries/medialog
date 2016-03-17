module MlogEntriesHelper
  
  class Repository_Coll
    
    attr_accessor :name, :stock_size, :image_size, :id

    def initialize(name, stock_size, image_size, id)
      @name = name
      @stock_size = stock_size
      @image_size = image_size
      @id = id
    end

  end

  def get_sizes(entries)
    colls = Hash.new

    entries.each do |entry|
      collection = Collection.find(entry.collection_id)
      puts(collection)
      col_title = collection.title #MLOG_VOCAB["collection_codes"][entry.collection_code].split(" :: ")[1]
      col_id = collection.id
      col_code = collection.collection_code
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
        colls[col_code.to_sym] = Repository_Coll.new(col_title, stock_size, image_size, col_id)
      else 
        coll = colls[col_code]
        new_image_size  = coll.image_size + image_size
        new_stock_size = coll.stock_size + stock_size
        colls[col_code.to_sym] = Repository_Coll.new(col_title, stock_size, new_image_size, col_id)
      end
    end

    return colls

  end

end
