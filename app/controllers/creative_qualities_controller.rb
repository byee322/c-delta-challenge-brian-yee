class CreativeQualitiesController < ApplicationController
  include ApplicationHelper
  def index
    @creative_qualities = CreativeQuality.all
    @normalized_scores = {}

    @creative_qualities.each do |quality|
    	@normalized_scores[quality.name] = 0
    end

    normalize_scores

    respond_to do |format|
      format.html
      format.json { render json: normalize_scores }
    end
  end
end
