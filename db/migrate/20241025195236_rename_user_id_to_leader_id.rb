class RenameUserIdToLeaderId < ActiveRecord::Migration[6.1]
  def change
    rename_column :bands, :user_id, :leader_id
  end
end
