class CreateJoinRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :join_requests do |t|

      t.timestamps
    end
  end
end
