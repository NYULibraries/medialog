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
#  imaging_success          :boolean
#  interpretation_success   :boolean
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
#

require 'spec_helper'

describe MlogEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
