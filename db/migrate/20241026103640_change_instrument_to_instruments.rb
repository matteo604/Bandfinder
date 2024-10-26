class ChangeInstrumentToInstruments < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :instrument, :instruments
  end
end
