class AddOriginalIdToMlog < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :original_id, :string
  end
end
