class AddPhotoToBuckets < ActiveRecord::Migration[6.0]
  def change
    add_column :buckets, :photo, :text
  end
end
