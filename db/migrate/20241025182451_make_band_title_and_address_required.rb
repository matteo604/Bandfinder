class MakeBandTitleAndAddressRequired < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bands, :title, false
    change_column_null :bands, :address, false
  end
end
