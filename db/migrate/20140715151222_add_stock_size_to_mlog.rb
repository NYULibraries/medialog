class AddStockSizeToMlog < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :stock_size, :string
  end
end
