require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  let(:user) { create(:user) }
  let(:course) { create(:course) }
  let(:valid_attributes) { { name: 'Updated Course', description: 'Updated Description' } }
  let(:invalid_attributes) { { name: '', description: '' } }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'GET #show' do
    context 'when course exists' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        get :show, params: { id: course.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when course does not exist' do
      before do
        get :show, params: { id: 0 }
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['errors']).to include("Couldn't find Course with 'id'=0")
      end
    end

    context 'when user is not authorized' do
      it 'raises CanCan::AccessDenied' do
        allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)
        expect {
          get :show, params: { id: course.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        put :update, params: { id: course.id, course: valid_attributes }
      end

      it 'updates the requested course' do
        course.reload
        expect(course.name).to eq(valid_attributes[:name])
        expect(course.description).to eq(valid_attributes[:description])
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        put :update, params: { id: course.id, course: invalid_attributes }
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end

    context 'when course does not exist' do
      before do
        put :update, params: { id: 0, course: valid_attributes }
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user is not authorized' do
      it 'raises CanCan::AccessDenied' do
        allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)
        expect {
          put :update, params: { id: course.id, course: valid_attributes }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET #reports' do
    context 'when user is authorized' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        get :reports, params: { id: course.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authorized' do
      it 'raises CanCan::AccessDenied' do
        allow(controller).to receive(:authorize!).and_raise(CanCan::AccessDenied)
        expect {
          get :reports, params: { id: course.id }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
