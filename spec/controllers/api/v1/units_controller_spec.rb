require 'rails_helper'

RSpec.describe Api::V1::UnitsController, type: :controller do
  let(:user) { create(:user, :teacher) }
  let(:valid_attributes) { { name: 'My new Unit Rampla', description: 'Omg this is a new unit', position: 1 } }
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
            "La validación falló: Name no puede estar en blanco, Description no puede estar en blanco"
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

  describe 'PUT #update' do
    let(:course) { user.selected_course }
    let!(:unit) { create(:unit, course: course, position: 2) }
    let!(:unit1) { create(:unit, course: course, position: 1) }
    let!(:unit3) { create(:unit, course: course, position: 3) }
    let(:new_attributes) { { name: 'Updated Unit Name', description: 'Updated description' } }

    context 'when user is authorized' do
      context 'with valid params' do
        before do
          put :update, params: { course_id: course.id, id: unit.id, unit: new_attributes }
        end

        it 'updates the requested unit' do
          unit.reload
          expect(unit.name).to eq('Updated Unit Name')
          expect(unit.description).to eq('Updated description')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when updating position' do
        context 'moving unit to a higher position' do
          before do
            put :update, params: { course_id: course.id, id: unit.id, unit: { position: 3 } }
          end

          it 'updates the unit position' do
            unit.reload
            expect(unit.position).to eq(3)
          end

          it 'adjusts other units positions correctly' do
            unit3.reload
            expect(unit3.position).to eq(2)
          end
        end

        context 'moving unit to a lower position' do
          before do
            put :update, params: { course_id: course.id, id: unit3.id, unit: { position: 1 } }
          end

          it 'updates the unit position' do
            unit3.reload
            expect(unit3.position).to eq(1)
          end

          it 'adjusts other units positions correctly' do
            unit1.reload
            expect(unit1.position).to eq(2)
          end
        end
      end

      context 'with invalid params' do
        before do
          put :update, params: { course_id: course.id, id: unit.id, unit: invalid_attributes }
        end

        it 'returns http unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error messages' do
          expect(JSON.parse(response.body)['errors']).to include(
            "La validación falló: Name no puede estar en blanco, Description no puede estar en blanco"
          )
        end
      end
    end

    context 'when user is not authorized' do
      let(:other_course) { create(:course) }
      let(:other_unit) { create(:unit, course: other_course) }

      it 'raises CanCan::AccessDenied' do
        expect {
          put :update, params: { course_id: other_course.id, id: other_unit.id, unit: new_attributes }
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when unit does not exist' do
      before do
        allow(controller).to receive(:authorize!).and_return(true)
        put :update, params: { course_id: course.id, id: 0, unit: new_attributes }
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['errors']).to include("Couldn't find Unit with 'id'=0 [WHERE \"units\".\"course_id\" = $1]")
      end
    end
  end
end
