class AnswersController < ApplicationController

  before_filter :get_answer, only: [:edit, :update, :destroy, :vote]
  before_action :authenticate_user_answer, only: :create 
 
  def create
    if @can_answer == true 
      @answer = Answer.new(answer_params)
      @answer.question_id = params[:question_id]
      @answer.user = current_user
      puts "11111111111111111"
      if @answer.save
        puts "2222222222222"
        flash[:success] = "Answered!"
        redirect_to question_path(params[:question_id])
      else
        redirect_to question_path(params[:question_id])
      end
    else
      flash[:notice] = "You are not within the radius."
      redirect_to question_path(params[:question_id])
    end
  end
  
  def update
    if @answer.update_attributes(answer_params)
      redirect_to question_path(@answer.question.id)
    else
      redirect_to question_path(@answer.question.id)
    end
  end
  
  def destroy
    question_id = @answer.question.id
    @answer.destroy!
    redirect_to question_path(question_id)
  end
  
  def vote
    vote = Vote.new
    vote.type = params[:type]
    vote.answer = @answer
    vote.user = current_user
    if vote.save
      redirect_to question_path(@answer.question)
    else
      redirect_to question_path(@answer.question)
    end
  end
  
  private
  
    def answer_params
      params.require(:answer).permit(:content)
    end
end
