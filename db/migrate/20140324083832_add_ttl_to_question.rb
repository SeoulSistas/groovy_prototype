class AddTtlToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :ttl, :float
    add_column :questions, :is_alive, :boolean
  end
end
