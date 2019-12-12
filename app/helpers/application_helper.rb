module ApplicationHelper

  def lookup_mlog_entry(col_id, m_id)
    MlogEntry.where("collection_id = ? and media_id =?", col_id, m_id) 
  end

  def get_in_bytes(media_size, unit)
    case unit
    when "KB"
      kb_to_byte(media_size)
    when "MB"
      mb_to_byte(media_size)
    when "GB"
      gb_to_byte(media_size)
    when "TB"
      tb_to_byte(media_size)
    end
  end

  def display_in_terabytes(bytes)
    bytes.nil? ? '' : ((((bytes / 1024.0) / 1024.0) / 1024.0) / 1024.0).round(2)
  end  

  def display_in_gigabytes(bytes)
    bytes.nil? ? '' : (((bytes / 1024.0) / 1024.0) / 1024.0).round(2)
  end  
  
  def display_in_megabytes(bytes)
    bytes.nil? ? '' : ((bytes / 1024.0) / 1024.0).round(2)
  end

  def display_in_kilobytes(bytes)
    bytes.nil? ? '' : (bytes / 1024.0).round(2)
  end

  def tb_to_byte(tbytes)
    tbytes.nil? ? 0.0 : (1099511627776.0 * tbytes).round(2)
  end

  def gb_to_byte(gbytes)
    gbytes.nil? ? 0.0 : (1073741824 * gbytes).round(2)
  end

  def mb_to_byte(mbytes)
    mbytes.nil? ? 0.0 : (1048576.0 * mbytes).round(2)
  end

  def kb_to_byte(kbytes)
    kbytes.nil? ? 0.0 : (1024.0 * kbytes).round(2)
  end

  def human_size(bytes)
    if(bytes <= 1023.0) then
      bytes.to_s + " B"
    elsif (bytes > 1023.0 && bytes <= 1048575.0) then 
      display_in_kilobytes(bytes).to_s + " KB"
    elsif (bytes > 1048575.0 && bytes <= 1073741823.0) then
      display_in_megabytes(bytes).to_s + " MB"
    elsif (bytes > 1073741823.0 && bytes <= 1099511627775.0) then
      display_in_gigabytes(bytes).to_s + " GB"
    elsif (bytes > 1099511627775) then
      display_in_terabytes(bytes).to_s + " TB"
    end
  end

  class Min_Col

    attr_accessor :c_code, :p_code, :c_title

    def initialize(c_code, p_code, c_title)
      @c_code = c_code
      @p_code = p_code
      @c_title = c_title
    end  
  end

  def getMinCollections
    min_cols = Hash.new
    cols = Collection.select("id, collection_code, partner_code, title")
    cols.each do |col|
      min_cols[col.id] = Min_Col.new(col.collection_code, col.partner_code, col.title)
    end
    min_cols
  end

  def getMinAccessions
    min_accs = Hash.new
    accs = Accession.select("id, accession_num")
    accs.each do |acc|
      min_accs[acc.id] = acc.accession_num
    end
    min_accs
  end
  
  def get_summaries(mlog_entries)
    summaries = Hash.new
    sum = 0.0
    image_sum = 0.0
    
    mlog_entries.each do |entry|
      if(entry.stock_unit == 'KB') then
        sum = sum + kb_to_byte(entry.stock_size_num)
      elsif(entry.stock_unit == 'MB') then
        sum = sum + mb_to_byte(entry.stock_size_num)
      elsif (entry.stock_unit == 'GB') then
        sum = sum + gb_to_byte(entry.stock_size_num)
      end

      if(entry.image_size_bytes != nil) then
        image_sum = image_sum + entry.image_size_bytes
      end
    end

    summaries["stock_size"] = human_size(sum)
    summaries["image_size"] = human_size(image_sum)

    summaries
  end

  def get_sizes(collections)

    collection_sizes = Hash.new

    collections.each do |collection|
      entries = MlogEntry.where(["collection_id = ?", collection.id])
      entries.each do |entry|
        stock_size = 0.0
        image_size = 0.0

        if entry.image_size_bytes != nil then
          image_size = entry.image_size_bytes
        end

        if entry.stock_size != nil then
          if(entry.stock_unit == 'KB') then
            stock_size = kb_to_byte(entry.stock_size_num)
          elsif(entry.stock_unit == 'MB') then
            stock_size = mb_to_byte(entry.stock_size_num)
          elsif (entry.stock_unit == 'GB') then
            stock_size = gb_to_byte(entry.stock_size_num)
          elsif(entry.stock_unit == 'TB') then
            stock_size = tb_to_byte(entry.stock_size_num)
          end
        end

        if !collection_sizes.include? entry.collection_id then
          collection_sizes[collection.id] = Repository_Coll.new(stock_size, image_size)
        else
          new_collection = collection_sizes[collection.id]
          new_image_size  = new_collection.image_size + image_size
          new_stock_size = new_collection.stock_size + stock_size
          collection_sizes[collection.id] = Repository_Coll.new(new_stock_size, new_image_size)
        end

      end
    end
    return collection_sizes
  end

  def get_collection_summaries(sizes)
    summaries = Hash.new
    stock = 0.0
    image = 0.0

    sizes.each do |size|
      stock = stock + size[1].stock_size
      image = image + size[1].image_size
    end

    summaries["stock_size"] = stock
    summaries["image_size"] = image

    summaries

  end

  class Repository_Coll
    attr_accessor :stock_size, :image_size

    def initialize(stock_size, image_size)
      @stock_size = stock_size
      @image_size = image_size
    end
  end

  def get_type_data(mlog_entries)
    type_hash = Hash.new
    mlog_entries.each do |entry|
      mediatype = entry[:mediatype]

      if (type_hash.key? mediatype) then
        type_hash[mediatype] = { :count => 1 + type_hash[mediatype][:count], :size => get_size(entry[:stock_size_num], entry[:stock_unit]) + type_hash[mediatype][:size] }
      else
        type_hash[mediatype] = { :count => 1, :size => get_size(entry[:stock_size_num], entry[:stock_unit]) }
      end

    end

    type_hash
  end

  def get_size(number, unit)
    if (unit == 'KB') then kb_to_byte(number)
    elsif(unit == 'MB') then mb_to_byte(number)
    elsif (unit == 'GB') then gb_to_byte(number)
    elsif(unit == 'TB') then tb_to_byte(number)
    end
  end

  def get_total_size(type_data)
    total_size = 0.0
    type_data.each do |key, value|
      total_size = total_size + value[:size]
    end
    total_size
  end
  
end
