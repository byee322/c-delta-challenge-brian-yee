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
    SurveyResponse.all.each do |survey|
      survey.answers.all.each do |answer|
        choice = answer.question_choice
        @normalized_scores[choice.creative_quality_id] += choice.score
      end
    end

    CreativeQuality.all.each do |quality|
      total_max_score = quality.max_score * SurveyResponse.all.count
      score = ((@normalized_scores[quality.id].to_f / total_max_score) * 100).round
      @normalized_scores[quality.id] = score
    end
  end

end
