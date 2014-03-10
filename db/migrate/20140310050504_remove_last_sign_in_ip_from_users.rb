class RemoveLastSignInIpFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :last_sign_in_ip, :string
  end
end
