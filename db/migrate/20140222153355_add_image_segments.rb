class AddImageSegments < ActiveRecord::Migration
  def change
    add_column :mlog_entries, :number_of_image_segments, :integer
  end
end
