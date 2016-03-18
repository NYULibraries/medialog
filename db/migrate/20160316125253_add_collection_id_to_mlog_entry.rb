class AddCollectionIdToMlogEntry < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :collection_id, :integer
  end
end
