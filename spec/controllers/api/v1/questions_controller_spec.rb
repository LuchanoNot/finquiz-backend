# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  let(:course) { create(:course, :with_units) }
  let(:user) { create(:user, :student) }
  let(:questionnaire) { create(:questionnaire, user: user) }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'GET #show' do
    context 'when the question exists' do
      let(:question) { create(:question) }

      before do
        user.courses << course
        questionnaire.units << course.units.first
        questionnaire.questions << question

        get :show, params: { id: question.id, questionnaire_id: questionnaire.id }
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end
    end

    context 'when the question does not exist' do
      before do
        get :show, params: { id: 0, questionnaire_id: questionnaire.id }
      end

      it 'returns a not found response' do
        expect(response).to be_not_found
      end

      it 'returns an error message' do
        expect(response.body).to include("Couldn't find Question with 'id'=0")
      end
    end

    context 'when the user is not authorized' do
      let(:question) { create(:question) }

      it 'raises CanCan::AccessDenied' do
        allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)

        expect {
          get :show, params: { id: question.id, questionnaire_id: questionnaire.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'POST #answer' do
    let(:question) { create(:question, :with_options) }

    before do
      user.courses << course
      questionnaire.units << course.units.first
      questionnaire.questions << question
    end

    context 'when the answer is a valid option' do
      before do
        post :answer, params: { id: question.id, questionnaire_id: questionnaire.id, answer: question.reload.options.first.id }
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'updates the answered_option' do
        expect(questionnaire.questionnaires_questions.find_by(question_id: question.id).reload.answered_option).to eq(question.options.first)
      end
    end

    context 'when the answer is an invalid option' do
      before do
        post :answer, params: { id: question.id, questionnaire_id: questionnaire.id, answer: 0 }
      end

      it 'returns a not found response' do
        expect(response).to be_not_found
      end

      it 'returns an error message' do
        expect(response.body).to include("Couldn't find Option with 'id'=0")
      end

      it 'does not update the answered_option' do
        expect { questionnaire.reload }.to_not change { questionnaire.questionnaires_questions.find_by(question_id: question.id).reload.answered_option }
      end
    end
  end
end
