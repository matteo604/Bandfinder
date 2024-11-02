class RemoveBandIdFromChats < ActiveRecord::Migration[7.1]
  def change
    remove_column :chats, :band_id, :bigint
  end
end
