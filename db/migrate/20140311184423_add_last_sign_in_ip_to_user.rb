class AddLastSignInIpToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_sign_in_ip, :string
  end
end
