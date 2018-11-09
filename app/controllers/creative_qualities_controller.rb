class CreativeQualitiesController < ApplicationController
  include ApplicationHelper
  def index
    @creative_qualities = CreativeQuality.all
    @normalized_scores = {}

    @creative_qualities.each do |quality|
    	@normalized_scores[quality.id] = 0
    end

    normalize_scores
    	    
    respond_to do |format|
      format.html
      format.json { render json: mock_creative_quality_scores }
    end
  end
end
