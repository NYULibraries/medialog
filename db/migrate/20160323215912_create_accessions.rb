class CreateAccessions < ActiveRecord::Migration
  def change
    create_table :accessions do |t|
      t.string :accession_num
      t.integer :collection_id
      t.text :accession_note

      t.timestamps
    end
  end
end
