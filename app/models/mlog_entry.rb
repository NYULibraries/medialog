# == Schema Information
#
# Table name: mlog_entries
#
#  id                       :uuid             not null, primary key
#  partner_code             :string(255)
#  collection_code          :string(255)
#  accession_num            :string(255)
#  media_id                 :integer
#  mediatype                :string(255)
#  manufacturer             :string(255)
#  manufacturer_serial      :string(255)
#  label_text               :string(255)
#  media_note               :text
#  photo_url                :string(255)
#  image_filename           :string(255)
#  interface                :string(255)
#  imaging_software         :string(255)
#  hdd_interface            :string(255)
#  imaging_success          :string(255)
#  interpretation_success   :string(255)
#  imaged_by                :string(255)
#  imaging_note             :text
#  image_format             :string(255)
#  encoding_scheme          :string(255)
#  partition_table_format   :string(255)
#  number_of_partitions     :integer
#  filesystem               :string(255)
#  has_dfxml                :boolean
#  has_ftk_csv              :boolean
#  image_size_bytes         :integer
#  md5_checksum             :string(255)
#  sha1_checksum            :string(255)
#  date_imaged              :datetime
#  date_ftk_loaded          :datetime
#  date_metadata_extracted  :datetime
#  date_photographed        :datetime
#  date_qc                  :datetime
#  date_packaged            :datetime
#  date_transferred         :datetime
#  created_at               :datetime
#  updated_at               :datetime
#  number_of_image_segments :integer
#  ref_id                   :string(255)
#  has_mactime_csv          :boolean
#

class MlogEntry < ActiveRecord::Base
  validates_length_of :md5_checksum, :minimum => 32, :maximum => 32, :allow_blank => true
  validates_length_of :sha1_checksum, :minimum => 40, :maximum => 40, :allow_blank => true
  validates :partner_code, presence: true
  validates :collection_code, presence: true
  validates :media_id, presence: true
  validates :mediatype, presence: true
  validates_uniqueness_of :media_id, :scope => [:collection_code, :partner_code]
end
