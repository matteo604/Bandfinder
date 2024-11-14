class ModifyRequest < ActiveRecord::Migration[7.1]
  def change
    add_reference :join_requests, :user, null: false, foreign_key: true
    add_reference :join_requests, :band, null: false, foreign_key: true
    add_column :join_requests, :status, :string, default: "pending"
  end
end
