class RenameCreatorIdInSessions < ActiveRecord::Migration[7.1]
  def change
    rename_column :sessions, :user_id, :creator_id
  end
end
