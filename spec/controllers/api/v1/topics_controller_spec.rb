require 'rails_helper'

RSpec.describe Api::V1::TopicsController, type: :controller do
  let(:teacher) { create(:user, role: :teacher) }
  let(:student) { create(:user, role: :student) }
  let(:course) { create(:course, users: [ teacher ]) }
  let(:unit) { create(:unit, course: course) }
  let!(:topic) { create(:topic, unit: unit) }

  let(:valid_attributes) { attributes_for(:topic) }
  let(:invalid_attributes) { attributes_for(:topic, name: nil) }

  describe 'POST #create' do
    context 'when user is authenticated and authorized as teacher' do
      before do
        auth_headers = teacher.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      context 'with valid params' do
        it 'creates a new Topic' do
          expect {
            post :create, params: { course_id: course.to_param, unit_id: unit.to_param, topic: valid_attributes }, format: :json
          }.to change(Topic, :count).by(1)
        end

        it 'return 200 status' do
          post :create, params: { course_id: course.to_param, unit_id: unit.to_param, topic: valid_attributes }, format: :json
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid params' do
        it 'does not create a new Topic' do
          expect {
            post :create, params: { course_id: course.to_param, unit_id: unit.to_param, topic: invalid_attributes }, format: :json
          }.to change(Topic, :count).by(0)
        end

        it 'renders a JSON response with errors for the new topic' do
          post :create, params: { course_id: course.to_param, unit_id: unit.to_param, topic: invalid_attributes }, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not authorized (e.g., student)' do
      before do
        auth_headers = student.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'raises CanCan::AccessDenied' do
        expect {
          post :create, params: { course_id: course.to_param, unit_id: unit.to_param, topic: valid_attributes }, format: :json
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: 'New Topic Name' } }

    context 'when user is authenticated and authorized' do
      before do
        auth_headers = teacher.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      context 'with valid params' do
        it 'updates the requested topic' do
          put :update, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param, topic: new_attributes }, format: :json
          topic.reload
          expect(topic.name).to eq('New Topic Name')
        end

        it 'return 200 status' do
          put :update, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param, topic: new_attributes }, format: :json
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid params' do
        it 'does not update the topic' do
          original_name = topic.name
          put :update, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param, topic: invalid_attributes }, format: :json
          topic.reload
          expect(topic.name).to eq(original_name)
        end

        it 'renders a JSON response with errors for the topic' do
          put :update, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param, topic: invalid_attributes }, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not authorized (e.g., student)' do
      before do
        auth_headers = student.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'raises CanCan::AccessDenied' do
        expect {
          put :update, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param, topic: new_attributes }, format: :json
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authorized as teacher' do
      before do
        auth_headers = teacher.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'destroys the requested topic' do
        expect {
          delete :destroy, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param }, format: :json
        }.to change(Topic, :count).by(-1)
      end

      it 'returns 200 status' do
        delete :destroy, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not authorized (e.g., student)' do
      before do
        auth_headers = student.create_new_auth_token
        request.headers.merge!(auth_headers)
      end

      it 'raises CanCan::AccessDenied' do
        expect {
          delete :destroy, params: { course_id: course.to_param, unit_id: unit.to_param, id: topic.to_param }, format: :json
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
