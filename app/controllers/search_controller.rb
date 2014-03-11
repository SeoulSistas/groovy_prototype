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
    @questions = Array.new
    if params[:pt_s] != nil and params[:pt_w] != nil and params[:pt_n] != nil and params[:pt_e] != nil
      pt_sw = Geokit::LatLng.new(params[:pt_s].to_f, params[:pt_w].to_f)
      pt_ne = Geokit::LatLng.new(params[:pt_n].to_f, params[:pt_e].to_f)
      bounds = Geokit::Bounds.new(pt_sw, pt_ne)
      #@questions = Question.geo_scope(:bounds=>bounds)
      @questions = Question.within(3, :origin => pt_sw)
    end
  end

end 
