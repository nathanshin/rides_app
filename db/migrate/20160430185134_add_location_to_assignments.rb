class AddLocationToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :location, :string
  end
end
