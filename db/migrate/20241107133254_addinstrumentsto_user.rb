class AddinstrumentstoUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :instruments, :string, array: true, default: []
  end
end
