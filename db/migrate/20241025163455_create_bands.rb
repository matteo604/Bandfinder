class CreateBands < ActiveRecord::Migration[7.1]
  def change
    create_table :bands do |t|
      t.string :title
      t.string :address
      t.string :genre
      t.integer :min_member
      t.text :description
      t.float :latitude
      t.float :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
