require 'rails_helper'

describe CreativeQuality do
  context 'associations' do
    it { is_expected.to have_many(:question_choices) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:max_score) }
	it { is_expected.to validate_presence_of(:locked) }
  end
end
