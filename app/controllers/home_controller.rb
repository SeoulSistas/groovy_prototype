class HomeController < ApplicationController

  skip_before_filter :authenticate_user!
  
  def index
    @questions = Question.all
  end

  def search
    @questions = Question.all
    # @questions = Array.new
    # all_questions = Question.all
    # if params[:n]!=nil and params[:s]!=nil and params[:e]!=nil and params[:w]!=nil
    #   for question in all_questions
    #     if question.latitude.between?(params[:s].to_f,params[:n].to_f) and question.longitude.between?(params[:w].to_f, params[:e].to_f)
    #       @questions.push(question)
    #     end
    #   end
    # end
    @questions.sort! {|a,b| b.created_at <=> a.created_at}
    render :partial => 'searched_questions', :locals => {:questions => @questions}
  end

end
