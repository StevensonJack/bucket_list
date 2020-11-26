class AddPhotoToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :photo, :text
    add_column :activities, :rating, :float
  end
end
