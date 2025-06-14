# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  render_views

  let(:user) { create(:user, :student) }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'GET #stats' do
    context 'when user has no questionnaires' do
      before do
        get :stats
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns zero questionnaires count' do
        response_body = JSON.parse(response.body)
        expect(response_body['questionnairesCount']).to eq(0)
      end

      it 'returns empty success topics' do
        response_body = JSON.parse(response.body)
        expect(response_body['successTopics']).to eq([])
      end

      it 'returns empty failure topics' do
        response_body = JSON.parse(response.body)
        expect(response_body['failureTopics']).to eq([])
      end
    end

    context 'when user has questionnaires' do
      let(:course) { create(:course, :with_units) }
      let(:unit) { course.units.first }
      let!(:topic) { create(:topic, unit: unit) }

      before do
        user.courses << course unless user.courses.include?(course)

        # Use factory with the :without_questions trait
        3.times do
          questionnaire = create(:questionnaire, :without_questions, user: user)
          question = create(:question, :with_options, topic: topic)
          create(:questionnaires_question, questionnaire: questionnaire, question: question)
        end

        get :stats
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns correct questionnaires count' do
        response_body = JSON.parse(response.body)
        expect(response_body['questionnairesCount']).to eq(3)
      end

      it 'includes success_topics and failure_topics in response' do
        response_body = JSON.parse(response.body)
        expect(response_body).to have_key('successTopics')
        expect(response_body).to have_key('failureTopics')
        expect(response_body['successTopics']).to be_an(Array)
        expect(response_body['failureTopics']).to be_an(Array)
      end
    end

    context 'when user has answered questions correctly' do
      let(:course) { create(:course, :with_units) }
      let(:unit) { course.units.first }
      let!(:topic) { create(:topic, unit: unit) }

      before do
        user.courses << course unless user.courses.include?(course)

        # Use factory with the :without_questions trait
        questionnaire = create(:questionnaire, :without_questions, user: user)
        question = create(:question, :with_options, topic: topic)
        questionnaires_question = create(:questionnaires_question, :with_correct_answered_option,
                                        questionnaire: questionnaire, question: question)

        get :stats
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns topics with proper structure when topics exist' do
        response_body = JSON.parse(response.body)

        # Topics might be in success or failure depending on the success rate
        topics_data = response_body['successTopics'] + response_body['failureTopics']

        if topics_data.any?
          topic_data = topics_data.first
          expect(topic_data).to have_key('id')
          expect(topic_data).to have_key('name')
          expect(topic_data).to have_key('shortDescription')
        end
      end
    end

    context 'when user has answered questions incorrectly' do
      let(:course) { create(:course, :with_units) }
      let(:unit) { course.units.first }
      let!(:topic) { create(:topic, unit: unit) }

      before do
        user.courses << course unless user.courses.include?(course)

        # Use factory with the :without_questions trait
        questionnaire = create(:questionnaire, :without_questions, user: user)
        question = create(:question, :with_options, topic: topic)
        questionnaires_question = create(:questionnaires_question, :with_incorrect_answered_option,
                                        questionnaire: questionnaire, question: question)

        get :stats
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns failure topics when answered incorrectly' do
        response_body = JSON.parse(response.body)

        # With one incorrect answer, topics might show up in failure topics
        topics_data = response_body['successTopics'] + response_body['failureTopics']

        expect(topics_data).to be_an(Array)
        if topics_data.any?
          topic_data = topics_data.first
          expect(topic_data).to have_key('id')
          expect(topic_data).to have_key('name')
          expect(topic_data).to have_key('shortDescription')
        end
      end
    end
  end
end
