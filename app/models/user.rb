class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  has_many :votes, dependent: :destroy
  has_many :up_votes, -> {where typpe: 'upp'}, foreign_key: 'user_id', class_name: 'Vote', dependent: :destroy
  has_many :down_votes, -> {where typpe: 'down'},  foreign_key: 'user_id', class_name: 'Vote', dependent: :destroy  
  
  
  def voted?(answer)
    self.votes.where('answer_id = ?', answer).exists?
  end
  
end
