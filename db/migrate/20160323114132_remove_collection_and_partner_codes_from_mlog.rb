class RemoveCollectionAndPartnerCodesFromMlog < ActiveRecord::Migration
  def change
  	remove_column :mlog_entries, :collection_code
  	remove_column :mlog_entries, :partner_code
  end
end
