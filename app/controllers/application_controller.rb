class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate_user!
  
  def get_question
    @question = Question.find(params[:id])
  end
  
  def get_answer
    @answer = Answer.find(params[:id])
  end

  def authenticate_user_answer
    question = Question.find(params[:question_id])
    ip_address = env['HTTP_X_REAL_IP'] ||= env['REMOTE_ADDR'] 
    curr_loc = Geokit::Geocoders::IpGeocoder.geocode(ip_address)
    @can_answer = false
    if curr_loc.success
      if question.distance_to([curr_loc.lat, curr_loc.lng]) <= question.radius
        @can_answer = true
      end
    end
end
  
end
