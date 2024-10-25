class MakeUserFieldsRequired < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :telephone_number, false
    change_column_null :users, :instrument, false
    change_column_null :users, :address, false
  end
end
