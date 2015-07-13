class AddStockUnitToMlogEntries < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :stock_unit, :string
  end
end
