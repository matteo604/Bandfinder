class ChangeTypeToJoinType < ActiveRecord::Migration[7.1]
  def change
    rename_column :join_requests, :type, :join_type
  end
end
