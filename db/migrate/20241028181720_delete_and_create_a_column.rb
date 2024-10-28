class DeleteAndCreateAColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :applications, :session_id
    add_reference :applications, :band_session, foreign_key: true
  end
end
