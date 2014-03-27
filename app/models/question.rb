class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy

  acts_as_mappable :default_units => :miles,
		   :default_formula => :sphere,
		   :distance_field_name => :distance,
		   :lat_column_name => :latitude,
 		   :lng_column_name => :longitude 
           
  def display_ttl
    end_time = self.created_at + self.ttl * 60
    curr_time = Time.now
    mins = ((end_time - curr_time) / 60).to_i
    if mins < 60
      mins.to_s + ' mins left'
    elsif mins < 1440
      hours = mins / 60
      hours.to_s + ' hours left'
    else
      days = mins/ 3600
      days.to_s + ' days left'
    end 
  end

end
