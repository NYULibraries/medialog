class AddCreatorsAndModifiersToCollections < ActiveRecord::Migration
  def change
  	add_column :collections, :created_by, :integer
  	add_column :collections, :modified_by, :integer
  end
end
