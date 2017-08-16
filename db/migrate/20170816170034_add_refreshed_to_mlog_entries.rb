class AddRefreshedToMlogEntries < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :is_refreshed, :boolean
  end
end
