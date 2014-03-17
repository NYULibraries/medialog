class MlogEntriesController < ApplicationController
  include ApplicationHelper
  before_action :set_mlog_entry, only: [:show, :edit, :update, :destroy]


  def search
    
  end
  
  
  def search_log    
    @result = MlogEntry.where(["partner_code = ? or collection_code = ? or media_id = ?",params[:partner], params[:collection], params[:media].to_i]) 
  end

  # GET /mlog_entries
  # GET /mlog_entries.json
  def index
    @mlog_entries = MlogEntry.all
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
      params.require(:mlog_entry).permit(:partner_code, :collection_code, :accession_num, :media_id, :mediatype, :manufacturer, :manufacturer_serial, :label_text, :media_note, :photo_url, :image_filename, :interface, :imaging_software, :hdd_interface, :imaging_success, :interpretation_success, :imaged_by, :imaging_note, :image_format, :encoding_scheme, :partition_table_format, :number_of_partitions, :filesystem, :has_dfxml, :has_ftk_csv, :image_size_bytes, :md5_checksum, :sha1_checksum, :date_imaged, :date_ftk_loaded, :date_metadata_extracted, :date_photographed, :date_qc, :date_packaged, :date_transferred, :number_of_image_segments)
    end
end
