class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :car_spots
      t.string :address
      t.text :geocode

      t.timestamps null: false
    end
  end
end
