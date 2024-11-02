class RemoveBandIdFromChats < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:chats, :band_id)
      remove_column :chats, :band_id, :bigint
    end
  end
end
