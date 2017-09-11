class AddStatusToAccessions < ActiveRecord::Migration
  def change
    add_column :accessions, :accession_state, :string
  end
end
