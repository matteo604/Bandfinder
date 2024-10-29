class AddColToTable < ActiveRecord::Migration[7.1]
  def change
    add_column :bands, :searching_for_instruments, :string
  end
end
