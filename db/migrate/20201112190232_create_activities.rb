class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.integer :budget
      t.string :location
      t.integer :time_frame
      t.integer :people_number
      t.string :category
      t.references :bucket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
