class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy

  acts_as_mappable 

end
