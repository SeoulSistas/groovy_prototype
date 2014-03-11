class RemoveCurrentSignInIpFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_sign_in_ip, :string
  end
end
