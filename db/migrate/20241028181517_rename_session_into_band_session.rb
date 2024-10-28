class RenameSessionIntoBandSession < ActiveRecord::Migration[7.1]
  def change
    rename_table :sessions, :band_sessions
  end
end
