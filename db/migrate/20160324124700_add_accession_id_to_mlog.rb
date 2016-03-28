class AddAccessionIdToMlog < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :accession_id, :integer
  end
end
