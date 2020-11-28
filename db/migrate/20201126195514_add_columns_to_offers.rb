class AddColumnsToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :origin, :string
    add_column :offers, :destination, :string
    add_column :offers, :flight_carrier, :string
  end
end
