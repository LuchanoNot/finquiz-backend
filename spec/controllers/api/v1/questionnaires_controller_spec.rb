# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QuestionnairesController, type: :controller do
  render_views

  let(:user) { create(:user, :student) }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'GET #show' do
    context 'when the questionnaire exists' do
      let(:questionnaire) { create(:questionnaire, user: user) }

      before do
        get :show, params: { id: questionnaire.id }
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end
    end

    context 'when the questionnaire does not exist' do
      before do
        get :show, params: { id: 0 }
      end

      it 'returns a not found response' do
        expect(response).to be_not_found
      end

      it 'returns an error message' do
        expect(response.body).to include("Couldn't find Questionnaire with 'id'=0")
      end
    end

    context 'when the user is not authorized' do
      let(:questionnaire) { create(:questionnaire) }

      it 'raises CanCan::AccessDenied' do
        allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)

        expect {
          get :show, params: { id: questionnaire.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET #index' do
    context 'when questionnaires exist' do
      let!(:questionnaires) { create_list(:questionnaire, 3, user: user) }

      before do
        create_list(:questionnaire, 5)
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns the correct number of questionnaires for the user' do
        expect(JSON.parse(response.body).length).to eq(3)
      end
    end

    context 'when no questionnaires for the user exist' do
      before do
        create_list(:questionnaire, 5)
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns an empty array' do
        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end
end
