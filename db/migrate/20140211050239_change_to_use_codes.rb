class ChangeToUseCodes < ActiveRecord::Migration
  def up
    rename_column :mlog_entries, :partner_id,      :partner_code
    change_column :mlog_entries, :partner_code,    :string
    rename_column :mlog_entries, :collection_id,   :collection_code
    change_column :mlog_entries, :collection_code, :string
    rename_column :mlog_entries, :accession_id,    :accession_num
    change_column :mlog_entries, :accession_num,   :string
  end
  # see: http://makandracards.com/makandra/18691-postgresql-vs-rails-migration-how-to-change-columns-from-string-to-integer
  def down
    rename_column :mlog_entries, :partner_code,    :partner_id
    change_column :mlog_entries, :partner_id,      'uuid USING CAST(partner_id AS uuid)'
    rename_column :mlog_entries, :collection_code, :collection_id
    change_column :mlog_entries, :collection_id,   'uuid USING CAST(collection_id AS uuid)'
    rename_column :mlog_entries, :accession_num,   :accession_id
    change_column :mlog_entries, :accession_id,    'uuid USING CAST(accession_id AS uuid)'
  end
end
