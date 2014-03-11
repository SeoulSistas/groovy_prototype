class SearchController < ApplicationController

  def filter
    #@filtered_questions = Array.new
    #@questions = Question.all
    #if params[:lat] != nil and params[:lng] != nil
    #  for question in @questions
    #    input_loc = Geokit::LatLng.new(params[:lat].to_f, params[:lng].to_f)
    #    q_loc = Geokit::LatLng.new(question.latitude, question.longitude)
    #    dist = q_loc.distance_from(input_loc, :unit => :miles)
    #    if dist <= question.radius
    #      @filtered_questions.push(question)
    #    end
    #  end
    #end
    
    @filtered_questions = Array.new
    @questions = Question.all
    if params[:s] != nil and params[:w] != nil and params[:n] != nil and params[:e] != nil
      #sw = Geokit::LatLng.new(params[:s].to_f, params[:w].to_f)
      #ne = Geokit::LatLng.new(params[:n].to_f, params[:e].to_f)
      #bounds = Geokit::Bounds.new(sw, ne)
      #@questions = Question.find :all, :bounds=>bounds
      for question in @questions
        if question.latitude < params[:n] and question.latitude > params[:s] and question.longitude < params[:e] and questoin.longitude < params[:w]
          @filtered_questions.push(question)
        end
      end
    end
    render :partial => 'filteredQuestions', :locals => {:filtered_questions => @filtered_questions}
  end

end 
