class AddForeignKeyForBandLeaderIdInChats < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :chats, :users, column: :band_leader_id
  end
end
