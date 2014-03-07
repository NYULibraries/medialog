class ChangigInterpretType < ActiveRecord::Migration
  def up
    change_column :mlog_entries, :interpretation_success, :string
  end

  def down
    change_column :mlog_entires, :interpretation_success, :boolean
  end

end
