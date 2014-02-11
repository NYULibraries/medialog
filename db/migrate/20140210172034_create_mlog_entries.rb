class CreateMlogEntries < ActiveRecord::Migration
  def change
    create_table :mlog_entries, id: :uuid  do |t|
      t.uuid :partner_id
      t.uuid :collection_id
      t.uuid :accession_id
      t.integer :media_id
      t.string :mediatype
      t.string :manufacturer
      t.string :manufacturer_serial
      t.string :label_text
      t.text :media_note
      t.string :photo_url
      t.string :image_filename
      t.string :interface
      t.string :imaging_software
      t.string :hdd_interface
      t.boolean :imaging_success
      t.boolean :interpretation_success
      t.string :imaged_by
      t.text :imaging_note
      t.string :image_format
      t.string :encoding_scheme
      t.string :partition_table_format
      t.integer :number_of_partitions
      t.string :filesystem
      t.boolean :has_dfxml
      t.boolean :has_ftk_csv
      t.integer :image_size_bytes
      t.string :md5_checksum
      t.string :sha1_checksum
      t.datetime :date_imaged
      t.datetime :date_ftk_loaded
      t.datetime :date_metadata_extracted
      t.datetime :date_photographed
      t.datetime :date_qc
      t.datetime :date_packaged
      t.datetime :date_transferred

      t.timestamps
    end
  end
end
