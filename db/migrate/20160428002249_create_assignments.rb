class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :event
      t.date :date
      t.text :assignments

      t.timestamps null: false
    end
  end
end
