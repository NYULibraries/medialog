require 'open-uri'

class MlogEntriesController < ApplicationController
  include ApplicationHelper
  include MlogEntriesHelper
  
  before_action :set_mlog_entry, only: [:show, :edit, :update, :destroy]
  
  def nav 
    mlog = MlogEntry.find(params[:id]) 
    id = mlog.media_id
    nId = 0
    if params[:dir] == "next"
     nId = id + 1
    elsif params[:dir] == "previous"
      nId = id - 1
    end

    nextMlog = MlogEntry.where("collection_id = ? and media_id =?", mlog.collection_id, nId)
    
    if nextMlog[0] != nil 
      redirect_to :action => 'show',  :id => nextMlog[0]
    else
      flash[:notice] = "The #{params[:dir]} record does not exist."
      redirect_to :action => 'show',  :id => mlog
    end 

  end

  def lookup
    mlog_entries = lookup_mlog_entry(params['collection_id'], params['media_id'])
    if mlog_entries.size != 0 then 
      redirect_to mlog_entries[0]
    else
      flash[:notice] = "id #{params[:media_id]} does not exist in current collection."
      redirect_to MlogEntry.find(params['current_id'])
    end
  end

  def clone
    source_entry = MlogEntry.find(params[:id])
    @mlog_entry = MlogEntry.new
    @mlog_entry[:collection_id] = source_entry[:collection_id]
    @mlog_entry[:accession_id] = source_entry[:accession_id]
    @mlog_entry[:mediatype] = source_entry[:mediatype]
    @mlog_entry[:box_number] = source_entry[:box_number]
    @mlog_entry[:media_id] = source_entry[:media_id] + 1
    @collection = Collection.find(source_entry.collection_id)
    @accession = Accession.find(source_entry.accession_id)
  end

  # GET /mlog_entries
  # GET /mlog_entries.json
  def index
    @mlog_entries = MlogEntry.order(updated_at: :desc).page params[:page]
    @collections = getMinCollections
    @accessions = getMinAccessions
  end

  # GET /mlog_entries/1
  # GET /mlog_entries/1.json
  def show

    @creator = "unknown"
    @modifier = "unknown"
    
    @collection = Collection.find(@mlog_entry.collection_id)
    @accession = Accession.find(@mlog_entry.accession_id)

    if @mlog_entry.created_by != nil then @creator = User.find(@mlog_entry.created_by).email end
    if @mlog_entry.modified_by != nil then @modifier = User.find(@mlog_entry.modified_by).email end
  end

  # GET /mlog_entries/new
  def new
    @mlog_entry = MlogEntry.new
    @collection = Collection.find(params[:id])
    @accession = Accession.find(params[:accession_id])
  end

  # GET /mlog_entries/1/edit
  def edit    
    @collection = Collection.find(@mlog_entry.collection_id)
    @accession = Accession.find(@mlog_entry.accession_id)
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
    
    @collection = Collection.find(@mlog_entry.collection_id)
    @accession = Accession.find(@mlog_entry.accession_id)

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
    collection = Collection.find(@mlog_entry.collection_id)
    @mlog_entry.destroy
    respond_to do |format|
      format.html { redirect_to collection}
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
      params.require(:mlog_entry).permit(
        :accession_num, :media_id, :mediatype, :manufacturer, :manufacturer_serial, :label_text, :media_note, 
        :photo_url, :image_filename, :interface, :imaging_software, :hdd_interface, :imaging_success, :interpretation_success, 
        :imaged_by, :imaging_note, :image_format, :encoding_scheme, :partition_table_format, :number_of_partitions, :filesystem, 
        :has_dfxml, :has_ftk_csv, :has_mactime_csv, :image_size_bytes, :md5_checksum, :sha1_checksum, :date_imaged, :date_ftk_loaded, 
        :date_metadata_extracted, :date_photographed, :date_qc, :date_packaged, :date_transferred, :number_of_image_segments, 
        :ref_id, :box_number, :stock_size, :sip_id, :original_id, :disposition_note, :stock_unit, :stock_size_num, :created_by, 
        :modified_by, :collection_id, :accession_id)
    end
end
