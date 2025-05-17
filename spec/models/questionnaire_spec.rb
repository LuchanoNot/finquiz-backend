# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  describe 'associations' do
    it { should have_many(:questionnaires_questions).dependent(:destroy) }
    it { should have_many(:questions).through(:questionnaires_questions) }

    it { should have_many(:questionnaires_units).dependent(:destroy) }
    it { should have_many(:units).through(:questionnaires_units) }
  end

  describe 'current_position' do
    let(:questionnaire) { create(:questionnaire) }

    context 'when the questionnaire has no questions answered' do
      it 'returns 0' do
        expect(questionnaire.current_position).to eq(0)
      end
    end

    context 'when the questionnaire has questions answered' do
      let(:count) { rand(1..questionnaire.questions.count) }

      before do
        questionnaire.questions.limit(count).each do |question|
          questionnaire.questionnaires_questions.find_by(question: question).update!(answered_option: question.options.correct.first)
        end
      end

      it 'returns the current position of the questionnaire' do
        expect(questionnaire.reload.current_position).to eq(count)
      end
    end
  end
end
