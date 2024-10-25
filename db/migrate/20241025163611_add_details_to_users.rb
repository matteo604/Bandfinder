class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :telephone_number, :string
    add_column :users, :instrument, :string
    add_column :users, :address, :string
    add_column :users, :leader, :boolean
    add_column :users, :status, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_reference :users, :band, foreign_key: true
  end
end
