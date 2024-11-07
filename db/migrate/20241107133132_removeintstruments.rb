class Removeintstruments < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :instruments
  end
end
