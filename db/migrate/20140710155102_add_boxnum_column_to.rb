class AddBoxnumColumnTo < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :box_number, :integer
  end
end
