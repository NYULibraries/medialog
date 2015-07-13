class AddStockSizeNumToMlogEntries < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :stock_size_num, :float
  end
end
