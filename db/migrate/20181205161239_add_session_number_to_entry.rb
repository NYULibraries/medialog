class AddSessionNumberToEntry < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :session_count, :integer
  	add_column :mlog_entries, :content_type, :string
  	add_column :mlog_entries, :structure, :string
  end
end
