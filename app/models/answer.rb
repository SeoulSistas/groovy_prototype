class Answer < ActiveRecord::Base

  belongs_to :user
  belongs_to :question
  
  has_many :votes, dependent: :destroy
  has_many :up_votes, -> {where typpe: 'upp'}, foreign_key: 'answer_id', class_name: 'Vote', dependent: :destroy
  has_many :down_votes, -> {where typpe: 'down'}, foreign_key: 'answer_id', class_name: 'Vote', dependent: :destroy  

end
