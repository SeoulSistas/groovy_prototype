class RemoveLastLocationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :last_location, :string
  end
end
