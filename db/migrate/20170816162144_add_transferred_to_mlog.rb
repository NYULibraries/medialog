class AddTransferredToMlog < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :is_transferred, :boolean
  end
end
