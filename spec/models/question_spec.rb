# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { should have_many(:options).dependent(:destroy) }
  end

  describe 'validations' do
    let(:question) { create(:question) }
    it { should validate_presence_of(:stem) }
    it { should validate_presence_of(:score) }

    context 'when options are valid' do
      it 'is valid with exactly one correct option and four options' do
        expect(question).to be_valid
      end
    end

    # context 'when options are invalid' do
    #   let(:invalid_question) { build(:question, options: []) }

    #   it 'is not valid with more than one correct option' do
    #     invalid_question.options << build(:option, correct: true)
    #     invalid_question.options << build(:option, correct: true)
    #     invalid_question.options << build(:option, correct: false)
    #     invalid_question.options << build(:option, correct: false)
    #     expect(invalid_question).not_to be_valid
    #     expect(invalid_question.errors[:options]).to include("shouldn't have more than one correct option")
    #   end
    # end
  end
end
