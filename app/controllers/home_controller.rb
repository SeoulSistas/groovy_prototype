class HomeController < ApplicationController

  skip_before_filter :authenticate_user!
  
  def index
    @questions = Question.all
  end
  
end
