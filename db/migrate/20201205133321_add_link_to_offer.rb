class AddLinkToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :skyscanner_link, :string
  end
end
