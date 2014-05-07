class AddMactimeToMlogEntry < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :has_mactime_csv, :boolean
  end
end
