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
      min_cols[col.id] = Min_Col.new(col.collection_code, col.partner_code, title)
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
  
end
