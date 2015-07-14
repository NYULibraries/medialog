require 'open-uri'

class MlogEntriesController < ApplicationController
  include ApplicationHelper
  include MlogEntriesHelper
  
  before_action :set_mlog_entry, only: [:show, :edit, :update, :destroy]

  def media
    @result = JSON.parse(open("http://localhost:9000/accession/media/" + params[:id]).read)
    puts @result.class
  end

  def search
    
  end
  
  def textfile
    @request = params[:file].split("_")
    @partner = MLOG_VOCAB["filename_partner_codes"][@request[0]]
    @col_code = @request[1] + @request[2]
    @media_num = @request[3]
    @result = MlogEntry.where("collection_code = ? and partner_code = ? and media_id =?", @col_code, @partner, @media_num)
    @size = @result.size
    puts @size.class

    respond_to do |format|
      format.html { 
        if @size == 1 then render json: @result[0].id 
        elsif @size == 0 then render json: "no resource" 
        end
      }

      format.json { 
        if @size == 1 then render json: @result[0].id 
        elsif @size == 0 then render json: "no resource" 
        end
      }
    end
  end

  def results
    
    if (params[:partner].empty? and params[:collection].empty? and params[:media].empty?)
      flash[:warning] = "One of the three fields must be filled in to execute the query"
      redirect_to :action => 'search'
    end
    
    @params = params
    conditions = { partner_code: params[:partner], 
               collection_code: params[:collection], 
               media_id: (params[:media].to_i unless params[:media].blank?) }

    @results = MlogEntry.where(conditions.delete_if {|k,v| v.blank?}).page params[:page]
  end

  def repository

    @entries = MlogEntry.where(["partner_code = ?", params[:repo]])
    @collections = get_sizes(@entries)
    @sum_stock = 0.0
    @sum_image = 0.0
  
    @collections.each do |coll|
      if coll[1].stock_size != nil then
        @sum_stock = @sum_stock + coll[1].stock_size
      end

      if coll[1].image_size != nil then
        @sum_image = @sum_image + coll[1].image_size
      end
    end
    
    @sum_image = human_size(@sum_image)
    @sum_stock = human_size(@sum_stock)
  end

  def collection
    @mlog_entries = MlogEntry.where("collection_code = ?", params[:collection_code]).order(media_id: :asc)
    @accessions = Set.new
    @mlog_entries.each do |mlog|
      unless mlog.accession_num.nil? || mlog.accession_num == ""
        @accessions.add(mlog.accession_num)
      end
    end


    @sum = 0.0
    @image_sum = 0.0
    @mlog_entries.each do |entry|
      if(entry.stock_unit == 'MB') then
        @sum = @sum + mb_to_byte(entry.stock_size_num)
      elsif (entry.stock_unit == 'GB') then
        @sum = @sum + gb_to_byte(entry.stock_size_num)  
      end

      if(entry.image_size_bytes != nil) then
        @image_sum = @image_sum + entry.image_size_bytes
      end
    end

    @sum = human_size(@sum)
    @image_sum = human_size(@image_sum)
    @mlog_entries = MlogEntry.where("collection_code = ?", params[:collection_code]).order(media_id: :asc).page params[:page]
  end
  
  def nav 
    mlog = MlogEntry.find(params[:id])    
    nId = mlog.media_id
    if params[:dir] == "next"
     nId += 1
    elsif params[:dir] == "prev"
      nId -= 1
    end

    nextMlog = MlogEntry.where("collection_code = ? and partner_code = ? and media_id =?", mlog.collection_code, mlog.partner_code, nId)[0]['id']
    redirect_to :action => 'show',  :id => nextMlog
  end

  def clone
    source_entry = MlogEntry.find(params[:id])
    @mlog_entry = MlogEntry.new
    @mlog_entry[:partner_code] = source_entry[:partner_code]
    @mlog_entry[:collection_code] = source_entry[:collection_code]
    @mlog_entry[:mediatype] = source_entry[:mediatype]
    @mlog_entry[:box_number] = source_entry[:box_number]
    @mlog_entry[:media_id] = source_entry[:media_id] + 1
  end

  def accession
    @mlog_entries = MlogEntry.where("accession_num = ? and collection_code = ?", params[:accession], params[:collection]).order(media_id: :asc).page params[:page]
  end

  def mlog_json
    respond_to do |format|
      format.html { 
        render json: MlogEntry.where("id = ?", params[:id])
      }

      format.json { 
        render json: params[:id]
      }
    end
  end

  def uuids
    @mlog_entries = MlogEntry.where("collection_code = ?", params[:collection_code]).order(media_id: :asc)
  end

  # GET /mlog_entries
  # GET /mlog_entries.json
  def index
    @mlog_entries = MlogEntry.order(updated_at: :desc).page params[:page]
  end

  # GET /mlog_entries/1
  # GET /mlog_entries/1.json
  def show
  end

  # GET /mlog_entries/new
  def new
    @mlog_entry = MlogEntry.new
  end

  # GET /mlog_entries/1/edit
  def edit
  end

  # POST /mlog_entries
  # POST /mlog_entries.json
  def create
    @mlog_entry = MlogEntry.new(mlog_entry_params)

    respond_to do |format|
      if @mlog_entry.save
        format.html { redirect_to @mlog_entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mlog_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @mlog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mlog_entries/1
  # PATCH/PUT /mlog_entries/1.json
  def update
    respond_to do |format|
      if @mlog_entry.update(mlog_entry_params)
        format.html { redirect_to @mlog_entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mlog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mlog_entries/1
  # DELETE /mlog_entries/1.json
  def destroy
    @mlog_entry.destroy
    respond_to do |format|
      format.html { redirect_to mlog_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mlog_entry
      @mlog_entry = MlogEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mlog_entry_params
      params.require(:mlog_entry).permit(:partner_code, :collection_code, :accession_num, :media_id, :mediatype, 
        :manufacturer, :manufacturer_serial, :label_text, :media_note, :photo_url, :image_filename, :interface, 
        :imaging_software, :hdd_interface, :imaging_success, :interpretation_success, :imaged_by, :imaging_note, 
        :image_format, :encoding_scheme, :partition_table_format, :number_of_partitions, :filesystem, :has_dfxml, 
        :has_ftk_csv, :has_mactime_csv, :image_size_bytes, :md5_checksum, :sha1_checksum, :date_imaged, :date_ftk_loaded, 
        :date_metadata_extracted, :date_photographed, :date_qc, :date_packaged, :date_transferred, :number_of_image_segments, 
        :ref_id, :box_number, :stock_size, :sip_id, :original_id, :disposition_note, :stock_unit, :stock_size_num)
    end
end
