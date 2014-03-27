class HomeController < ApplicationController

  skip_before_filter :authenticate_user!
  
  def index
    if !user_signed_in?
      redirect_to welcome_path
    end
  end
      
  def search
   questions_at_location = []
    live_questions = Question.where(is_alive: true)
    if params[:n]!=nil && params[:s]!=nil && params[:e]!=nil && params[:w]!=nil
      for question in live_questions
        if question.latitude.between?(params[:s].to_f,params[:n].to_f) and question.longitude.between?(params[:w].to_f, params[:e].to_f)
          questions_at_location.push(question)
        end
      end
    end
    @questions = get_and_update_live_questions(questions_at_location)
    @questions.sort! {|a,b| b.created_at <=> a.created_at}
    render :partial => 'searched_questions', :locals => {:questions => @questions}
  end

  
  def get_and_update_live_questions(questions_at_location)
    live_questions = Array.new
    curr_time = DateTime.now
    for question in questions_at_location
      if !question.ttl.nil?
        end_time = question.created_at + question.ttl * 60
        if curr_time.between?(question.created_at, end_time)
          question.is_alive = true
          live_questions.push(question)
        else
          question.is_alive = false
        end
        question.save
      end
    end
    live_questions
  end

end
