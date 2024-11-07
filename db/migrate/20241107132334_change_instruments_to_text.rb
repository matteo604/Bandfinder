class ChangeInstrumentsToText < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :instruments, :text, default: '[]'
  end
end
