class QuestionsController < ApplicationController

  before_filter :get_question, only: [:show, :edit, :update, :destroy]
  
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to root_path
    else
      render 'new'
    end

    # Get current location information using request's IP address
    @question.ip_address = env['HTTP_X_REAL_IP'] ||= env['REMOTE_ADDR']
    loc = Geokit::Geocoders::IpGeocoder.geocode(@question.ip_address)
    if loc.success
      @question.curr_lat = loc.lat
      @question.curr_lng = loc.lng
      if @question.distance_to([loc.lat, loc.lng]) <= @question.radius
        @question.is_asking_about_curr_loc = true
      else
        @question.is_asking_about_curr_loc = false
      end
    end
  end
     
  def update
    if @question.update_attributes(question_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end
    
  def destroy
    @question.destroy!
    redirect_to root_path
  end
  
  def show
    @answers = @question.answers
  end
  
  private
      
    def question_params
      params.require(:question).permit(:content, :radius, :longitude, :latitude)
    end
end
