class ChangeLabelToText < ActiveRecord::Migration
  def change
    change_column	:mlog_entries, :label_text, :text
  end

end
