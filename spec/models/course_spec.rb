# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { build(:course, :with_units) }

  describe 'associations' do
    it { should have_many(:course_users).dependent(:destroy) }
    it { should have_many(:users).through(:course_users) }
    it { should have_many(:units).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it 'is valid with valid attributes' do
      expect(course).to be_valid
    end

    it 'is not valid without a name' do
      course.name = nil
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is not valid without a description' do
      course.description = nil
      expect(course).not_to be_valid
      expect(course.errors[:description]).to include("no puede estar en blanco")
    end
  end

  describe '#methods' do
    describe '#average_completed_questionnaires_per_student' do
      before do
        create_list(:user, 2, role: :student, courses: [ course ])
        create(:user, role: :teacher, courses: [ course ])
        create_list(:questionnaire, 3, :completed, user: course.users.first)
      end

      it 'returns the average number of completed questionnaires per student' do
        expect(course.average_completed_questionnaires_per_student).to eq(1.5)
      end
    end

    describe '#average_result' do
      let!(:saved_course) { create(:course, :with_units) }
      let!(:student) { create(:user, role: :student, selected_course: saved_course) }

      before do
        saved_course.course_users.create!(user: student)

        questionnaire = create(:questionnaire, :without_questions, user: student)

        saved_course.units.each do |unit|
          topic = create(:topic, unit: unit)
          question = create(:question, :with_options, topic: topic)

          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.correct.first)

          create(:questionnaires_unit, questionnaire: questionnaire, unit: unit)
        end
      end

      it 'returns the average result' do
        expect(saved_course.average_result).to eq(100.0)
      end
    end

    describe '#active_students' do
      it 'returns the active students' do
        create_list(:user, 2, role: :student, courses: [ course ])
        create(:user, role: :teacher, courses: [ course ])
        create_list(:questionnaire, 3, :completed, user: course.users.first)
        expect(course.active_students).to eq(
          course.users.student.select { |student| student.questionnaires.any?(&:is_completed?) }
        )
      end
    end

    describe '#best_result_topic' do
      let!(:saved_course) { create(:course, :with_units) }
      let!(:student) { create(:user, role: :student, selected_course: saved_course) }
      let!(:topic1) { create(:topic, unit: saved_course.units.first, name: 'Topic 1') }
      let!(:topic2) { create(:topic, unit: saved_course.units.last, name: 'Topic 2') }

      before do
        saved_course.course_users.create!(user: student)
        questionnaire = create(:questionnaire, :without_questions, user: student)

        3.times do
          question = create(:question, :with_options, topic: topic1)
          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.correct.first)
        end

        2.times do
          question = create(:question, :with_options, topic: topic2)
          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.correct.first)
        end

        question = create(:question, :with_options, topic: topic2)
        create(:questionnaires_question,
               questionnaire: questionnaire,
               question: question,
               answered_option: question.options.where(correct: false).first)

        saved_course.units.each do |unit|
          create(:questionnaires_unit, questionnaire: questionnaire, unit: unit)
        end
      end

      it 'returns the topic with the highest success rate' do
        expect(saved_course.best_result_topic).to eq(topic1)
      end
    end

    describe '#worst_result_topic' do
      let!(:saved_course) { create(:course, :with_units) }
      let!(:student) { create(:user, role: :student, selected_course: saved_course) }
      let!(:topic1) { create(:topic, unit: saved_course.units.first, name: 'Topic 1') }
      let!(:topic2) { create(:topic, unit: saved_course.units.last, name: 'Topic 2') }

      before do
        saved_course.course_users.create!(user: student)
        questionnaire = create(:questionnaire, :without_questions, user: student)

        3.times do
          question = create(:question, :with_options, topic: topic1)
          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.correct.first)
        end

        1.times do
          question = create(:question, :with_options, topic: topic2)
          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.correct.first)
        end

        9.times do
          question = create(:question, :with_options, topic: topic2)
          create(:questionnaires_question,
                 questionnaire: questionnaire,
                 question: question,
                 answered_option: question.options.where(correct: false).first)
        end

        saved_course.units.each do |unit|
          create(:questionnaires_unit, questionnaire: questionnaire, unit: unit)
        end
      end

      it 'returns the topic with the lowest success rate' do
        expect(saved_course.worst_result_topic).to eq(topic2)
      end
    end
  end
end
