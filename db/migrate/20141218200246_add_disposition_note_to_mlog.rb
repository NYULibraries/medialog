class AddDispositionNoteToMlog < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :disposition_note, :string
  end
end
