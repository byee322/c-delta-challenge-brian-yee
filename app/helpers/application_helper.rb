module ApplicationHelper
  def mock_creative_quality_scores
    scores = [67, -25, 50]
    data = []

    CreativeQuality
      .limit(3)
      .each_with_index do |creative_quality, i|
      data << creative_quality.as_json.merge(
        score: scores[i]
      )
    end
    data
  end

  def normalize_scores
    @normalized_scores = {}

    CreativeQuality.all.each do |quality|
      @normalized_scores[quality.name] = {
        :description => quality.description,
        :score => 0
      }
    end

    SurveyResponse.all.each do |survey|
      survey.answers.all.each do |answer|
        choice = answer.question_choice
        @normalized_scores[CreativeQuality.find(choice.creative_quality_id).name][:score] += choice.score
      end
    end

    CreativeQuality.all.each do |quality|
      total_max_score = quality.max_score * SurveyResponse.all.count
      score = ((@normalized_scores[quality.name][:score].to_f / total_max_score) * 100).round
      @normalized_scores[quality.name][:score] = score
    end

    @normalized_scores
  end

end
