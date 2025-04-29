# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionnairesQuestion, type: :model do
  describe 'associations' do
    it { should belong_to(:questionnaire) }
    it { should belong_to(:question) }
    it { should belong_to(:answered_option).optional }
  end

  describe 'validations' do
    subject { create(:questionnaires_question) }

    it { should validate_presence_of(:position) }
    it { should validate_uniqueness_of(:position).scoped_to(:questionnaire_id) }
    it { should validate_numericality_of(:position).is_greater_than_or_equal_to(0) }

    it { should validate_uniqueness_of(:question_id).scoped_to(:questionnaire_id) }
  end

  describe 'methods' do
    describe '#correct' do
      context 'when the question has no answered question' do
        subject { create(:questionnaires_question) }

        it 'returns nil' do
          expect(subject.correct).to be_nil
        end
      end

      context 'when the question has an answered question' do
        context 'when the answered question is correct' do
          subject { create(:questionnaires_question, :with_correct_answered_option) }

          it 'returns true' do
            expect(subject.correct).to eq(true)
          end
        end

        context 'when the answered question is incorrect' do
          subject { create(:questionnaires_question, :with_incorrect_answered_option) }

          it 'returns false' do
            expect(subject.correct).to eq(false)
          end
        end
      end
    end
  end
end
