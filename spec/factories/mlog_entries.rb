# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mlog_entry do
    partner_id ""
    collection_id ""
    accession_id ""
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
