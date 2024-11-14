class AddTypeToRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :join_requests, :type, :string, null: false
  end
end
