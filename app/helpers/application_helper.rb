module ApplicationHelper

  def display_in_gigabytes(bytes)
    bytes.nil? ? '' : (((bytes / 1024.0) / 1024.0) / 1024.0).round(2)
  end  
  
  def display_in_megabytes(bytes)
    bytes.nil? ? '' : ((bytes / 1024.0) / 1024.0).round(2)
  end

  def display_in_kilabytes(bytes)
    bytes.nil? ? '' : (bytes / 1024.0).round(2)
  end

  def tb_to_byte(tbyte)
    tbytes.nil? ? 0.0 : ((((tbytes * 1024.0) * 1024.0) * 1024.0) * 1924.0).round(2)
  end

  def gb_to_byte(gbytes)
    gbytes.nil? ? 0.0 : (((gbytes * 1024.0) * 1024.0) * 1024.0).round(2)
  end

  def mb_to_byte(mbytes)
    mbytes.nil? ? 0.0 : ((mbytes * 1024.0) * 1024.0).round(2)
  end

  def kb_to_byte(kbytes)
    kbytes.nil? ? 0.0 : (kbytes * 1024.0).round(2)
  end

  def human_size(bytes)
  	if(bytes <= 1024.0) then
  	  bytes.to_s + " B"
  	elsif (bytes > 1024.0 && bytes <= 1048576.0) then 
 	  display_in_kilabytes(bytes).to_s + " KB"
   	elsif (bytes > 1048576.0 && bytes <= 1073741824.0) then
   	  display_in_megabytes(bytes).to_s + " MB"
   	elsif (bytes > 1073741824.0) then
   	  display_in_gigabytes(bytes).to_s + " GB"
   	end
  end

  class Min_Col

    attr_accessor :c_code, :p_code

    def initialize(c_code, p_code)
      @c_code = c_code
      @p_code = p_code
    end  
  end

  def getMinCollections
    min_cols = Hash.new
    cols = Collection.select("id, collection_code, partner_code")
    cols.each do |col|
      min_cols[col.id] = Min_Col.new(col.collection_code, col.partner_code)
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
  
end
