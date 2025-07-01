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

  describe 'is_completed?' do
    let(:questionnaire) { create(:questionnaire) }

    context 'when the questionnaire has no questions answered' do
      it 'returns false' do
        expect(questionnaire.is_completed?).to be_falsey
      end
    end

    context 'when the questionnaire is completed' do
      let(:questionnaire) { create(:questionnaire, :completed) }

      it 'returns true' do
        expect(questionnaire.is_completed?).to be_truthy
      end
    end
  end

  describe 'stats' do
    let!(:course) { create(:course, :with_units, units_count: 1) }
    let!(:questionnaire) { create(:questionnaire, :without_questions) }
    let!(:topic1) { create(:topic, unit: course.units.first, name: 'Topic 1') }
    let!(:topic2) { create(:topic, unit: course.units.first, name: 'Topic 2') }

    let(:topic1_correct_questions) { Faker::Number.between(from: 1, to: 3) }
    let(:topic1_incorrect_questions) { Faker::Number.between(from: 1, to: 3) }
    let(:topic2_correct_questions) { Faker::Number.between(from: 1, to: 3) }
    let(:topic2_incorrect_questions) { Faker::Number.between(from: 1, to: 3) }

    before do
      topic1_correct_questions.times do
        question = create(:question, :with_options, topic: topic1)
        create(:questionnaires_question,
               questionnaire: questionnaire,
               question: question,
               answered_option: question.options.correct.first)
      end

      topic1_incorrect_questions.times do
        question = create(:question, :with_options, topic: topic1)
        create(:questionnaires_question,
               questionnaire: questionnaire,
               question: question,
               answered_option: question.options.where(correct: false).first)
      end

      topic2_correct_questions.times do
        question = create(:question, :with_options, topic: topic2)
        create(:questionnaires_question,
               questionnaire: questionnaire,
               question: question,
               answered_option: question.options.correct.first)
      end

      topic2_incorrect_questions.times do
        question = create(:question, :with_options, topic: topic2)
        create(:questionnaires_question,
               questionnaire: questionnaire,
               question: question,
               answered_option: question.options.where(correct: false).first)
      end
    end

    it 'returns the correct total' do
      total_correct_questions = topic1_correct_questions + topic2_correct_questions
      total_incorrect_questions = topic1_incorrect_questions + topic2_incorrect_questions
      total_questions = total_correct_questions + total_incorrect_questions

      expect(questionnaire.stats[:total]).to eq((total_correct_questions.to_f / total_questions * 100).round(1))
    end

    it 'returns the correct stats by topic' do
      expect(questionnaire.stats[:stats_by_topic]).to eq([
        { topic_name: topic1.name, topic_id: topic1.id, total: (topic1_correct_questions.to_f / (topic1_correct_questions + topic1_incorrect_questions) * 100).round(1) },
        { topic_name: topic2.name, topic_id: topic2.id, total: (topic2_correct_questions.to_f / (topic2_correct_questions + topic2_incorrect_questions) * 100).round(1) }
      ])
    end
  end
end
