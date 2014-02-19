class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content, null:false, default: ''
      t.string :location
      t.references :user, null: false
      t.timestamps
    end
  end
end
