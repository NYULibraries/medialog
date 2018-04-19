class AddCreatorsAndModifiersToAccessions < ActiveRecord::Migration
  def change
  	add_column :accessions, :created_by, :integer
  	add_column :accessions, :modified_by, :integer
  end
end
