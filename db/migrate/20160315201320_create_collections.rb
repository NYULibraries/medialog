class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.string :collection_code
      t.string :partner_code

      t.timestamps
    end
  end
end
