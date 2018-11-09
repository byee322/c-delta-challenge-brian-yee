class SurveyResponsesController < ApplicationController
  def show
    @survey_response = SurveyResponse
    .includes(
      answers: [
        question_choice: [
          question: :question_choices
        ]
      ]
    )
    .find(params[:id])
    
    #hash to make for max scores and raw scores
    @creative_qualities_scores ={}

    #private methods to make hash
    get_max_scores
    calculate_raw_scores
  end

  def index
    @survey_responses = SurveyResponse.all
  end

  private 

  def get_max_scores
    
    # get all max scores ONLY if they are not locked
    # TODO: admin feature to unlock and recalculate possible scores

    if CreativeQuality.isLocked === false
      Question.all.each do |question| 
        question.calculate_max_score
      end
    end

    CreativeQuality.all.each do |quality|
      name = quality.name
      max_score = quality.max_score
      @creative_qualities_scores.merge!({
        quality.name => {
          :max_score => max_score
        } 
      })

      quality.locked = true
      quality.save
    end
  end

  def calculate_raw_scores
    #iterate over each answer
    @survey_response.answers.each do |answer|


      question_choice = QuestionChoice.find(answer.question_choice_id)
      creative_quality_name = CreativeQuality.find(question_choice.creative_quality_id).name

      #check to see if already exists in the hash
      if(@creative_qualities_scores.include?(creative_quality_name) && @creative_qualities_scores[creative_quality_name][:raw_score] != nil)
        current_score = @creative_qualities_scores[creative_quality_name][:raw_score]
        @creative_qualities_scores.merge!({
          creative_quality_name => {
            :max_score => @creative_qualities_scores[creative_quality_name][:max_score],
            :raw_score => current_score + question_choice.score
          }
        })
      else
      #else add it to the hash since it doesn't exist  
        @creative_qualities_scores.merge!({
          creative_quality_name => {
            :max_score => @creative_qualities_scores[creative_quality_name][:max_score],
            :raw_score => question_choice.score
          }
        })
      end
    end
  end
end
