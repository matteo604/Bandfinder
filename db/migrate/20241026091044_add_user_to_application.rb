class AddUserToApplication < ActiveRecord::Migration[7.1]
  def change
    add_reference :applications, :user, null: false, foreign_key: true
  end
end
