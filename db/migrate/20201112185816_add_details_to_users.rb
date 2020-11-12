class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :birthday, :date
  end
end
