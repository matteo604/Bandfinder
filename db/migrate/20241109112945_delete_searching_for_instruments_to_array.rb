class DeleteSearchingForInstrumentsToArray < ActiveRecord::Migration[7.1]
  def change
    remove_column :bands, :searching_for_instruments
  end
end
