class RenameBandIdToBandLeaderId < ActiveRecord::Migration[6.1]
  def change
    rename_column :chats, :band_id, :band_leader_id
  end
end
