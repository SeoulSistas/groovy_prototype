class SearchController < ApplicationController

  def filter
    @filtered_questions = Array.new
    @questions = Question.all
    if params[:lat] != nil and params[:lng] != nil
      for question in @questions
        input_loc = Geokit::LatLng.new(params[:lat].to_f, params[:lng].to_f)
        q_loc = Geokit::LatLng.new(question.latitude, question.longitude)
        dist = q_loc.distance_from(input_loc, :unit => :miles)
        if dist <= question.radius
          @filtered_questions.push(question)
        end
      end
    end
    render :partial => 'filteredQuestions', :locals => {:filtered_questions => @filtered_questions}
  end

end 
