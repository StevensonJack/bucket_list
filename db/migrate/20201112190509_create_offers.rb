class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.float :rating
      t.float :price
      t.date :start_date
      t.date :end_date
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
