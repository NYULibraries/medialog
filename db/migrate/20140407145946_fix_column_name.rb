class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :mlog_entries, :refID, :ref_id

  end
end
