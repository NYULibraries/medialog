class ChangeBytesizeToBigInt < ActiveRecord::Migration
  def up
    change_column :mlog_entries, :image_size_bytes, :integer, limit: 8
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

