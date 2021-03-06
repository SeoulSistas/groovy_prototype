class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :typpe, null: false, default: 'upp'
      t.references :answer
      t.references :user
      t.timestamps
    end
    
    add_index :votes, :answer_id
    add_index :votes, :user_id
  end
end
