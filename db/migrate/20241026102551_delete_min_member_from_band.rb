class DeleteMinMemberFromBand < ActiveRecord::Migration[7.1]
  def change
    remove_column :bands, :min_member
  end
end
