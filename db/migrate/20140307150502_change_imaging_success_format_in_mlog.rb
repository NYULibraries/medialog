class ChangeImagingSuccessFormatInMlog < ActiveRecord::Migration
  def up
    change_column :mlog_entries, :imaging_success, :string
  end

  def down
    change_column :mlog_entires, :imaging_success, :boolean
  end
end
