class RenameEventsIdtoSessionId < ActiveRecord::Migration[7.1]
  def change
    rename_column :reviews, :events_id, :session_id
    change_column_null :reviews, :session_id, true
  end
end
