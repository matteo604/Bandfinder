class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.references :session, null: false, foreign_key: true
      t.references :band, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
