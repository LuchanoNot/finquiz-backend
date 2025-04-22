require 'rails_helper'

RSpec.describe Api::V1::UnitsController, type: :controller do
  let(:user) { create(:user, :teacher) }
  let(:valid_attributes) { { name: 'My new Unit Rampla', description: 'Omg this is a new unit' } }
  let(:invalid_attributes) { { name: '', description: '' } }

  before do
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end

  describe 'POST #create' do
    context 'when user is authorized' do
      let (:course) { user.selected_course }
      context 'with valid params' do
        before do
          post :create, params: { course_id: course.id, unit: valid_attributes }
        end

        it 'creates a new Unit' do
          expect(Unit.count).to eq(1)
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end
      context 'with invalid params' do
        before do
          allow(controller).to receive(:authorize!).and_return(true)
          post :create, params: { course_id: course.id, unit: invalid_attributes }
        end

        it 'does not create a new Unit' do
          expect(Unit.count).to eq(0)
        end

        it 'returns http unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error messages' do
          expect(JSON.parse(response.body)['errors']).to include(
            "Name no puede estar en blanco", "Description no puede estar en blanco"
          )
        end
      end
    end
    context 'when user is not authorized' do
      let (:course) { create(:course) }
      it 'raises CanCan::AccessDenied' do
        expect {
          post :create, params: { course_id: course.id, unit: valid_attributes }
        }.to raise_error(CanCan::AccessDenied)
      end
    end
    context 'when course does not exist' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        post :create, params: { course_id: 0, unit: valid_attributes }
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['errors']).to include("Couldn't find Course with 'id'=0")
      end
    end
  end
end
