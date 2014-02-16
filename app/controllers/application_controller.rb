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
  
end
