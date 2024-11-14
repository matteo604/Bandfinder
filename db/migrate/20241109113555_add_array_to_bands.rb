class AddArrayToBands < ActiveRecord::Migration[7.1]
  def change
    add_column :bands, :searching_for_instruments, :string, array: true, default: []
  end
end
