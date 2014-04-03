class AddRefIdToMlog < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :refID, :string
  end
end
