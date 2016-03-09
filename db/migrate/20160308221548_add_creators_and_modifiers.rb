class AddCreatorsAndModifiers < ActiveRecord::Migration
  def change
  	add_column :mlog_entries, :created_by, :integer
  	add_column :mlog_entries, :modified_by, :integer
  end
end
