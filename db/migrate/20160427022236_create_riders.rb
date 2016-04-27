class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.text :geocode

      t.timestamps null: false
    end
  end
end
