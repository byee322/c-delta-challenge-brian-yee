class Question < ApplicationRecord
  has_many :question_choices, inverse_of: :question

  validates :title, presence: true

  accepts_nested_attributes_for(:question_choices)


  def calculate_max_score

  	#Note: Calculating max score every time coming to the show page 
  	# If questions and question choices change it will still show proper max_scores

  	#Do i need to check if it's the same creative quality? 
  	#I'm assuming every question's choices has the same creative quality 

	creative_quality = CreativeQuality.find(self.question_choices[0].creative_quality_id)
  	max_scores = []

  	self.question_choices.each do |choice|
  		max_scores << choice.score
  	end

  	max = max_scores.max
  	
  	if max > 0
  		creative_quality.max_score += max
		creative_quality.save
  	end
	
  end

end
