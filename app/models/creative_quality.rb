class CreativeQuality < ApplicationRecord
  has_many :question_choices

  validates :name, :description, :color, :max_score, :locked, presence: true

  def self.isLocked
  	isLocked = false
  	CreativeQuality.all.each do |quality|
  		if quality.locked
  			isLocked = true
  			break
  		end
  	end
  	isLocked
  end

end
