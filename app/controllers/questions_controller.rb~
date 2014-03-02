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
