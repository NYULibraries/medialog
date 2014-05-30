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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mlog_entry do
    partner_code "My Partner Code"
    collection_code "My Collection Code"
    accession_num "My Accession Number"
    media_id 1
    mediatype "MyString"
    manufacturer "MyString"
    manufacturer_serial "MyString"
    label_text "MyString"
    media_note "MyText"
    photo_url ""
    image_filename "MyString"
    interface "MyString"
    imaging_software "MyString"
    hdd_interface "MyString"
    imaging_success false
    interpretation_success false
    imaged_by "MyString"
    imaging_note "MyText"
    image_format "MyString"
    encoding_scheme "MyString"
    partition_table_format "MyString"
    number_of_partitions 1
    filesystem "MyString"
    has_dfxml false
    has_ftk_csv false
    image_size_bytes 1
    md5_checksum "MyString"
    sha1_checksum "MyString"
    date_imaged "2014-02-10 12:20:35"
    date_ftk_loaded "2014-02-10 12:20:35"
    date_metadata_extracted "2014-02-10 12:20:35"
    date_photographed "2014-02-10 12:20:35"
    date_qc "2014-02-10 12:20:35"
    date_packaged "2014-02-10 12:20:35"
    date_transferred "2014-02-10 12:20:35"
  end
end
