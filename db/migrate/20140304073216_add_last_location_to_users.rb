class AddLastLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_location, :string
  end
end
