class AddFileSystemsToMlogEntries < ActiveRecord::Migration
  def change
  	add_column	:mlog_entries, :file_systems, :string, array: true, default: []
  end
end
