class RemoveForeignKeyFromBandLeaderIdInChats < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :chats, column: :band_leader_id
  end
end
