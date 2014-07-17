class AddSipToMlog < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :sip_id, :integer
  end
end
