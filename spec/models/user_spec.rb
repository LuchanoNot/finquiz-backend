# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'enums' do
    it { should define_enum_for(:role).with_values([ :student, :teacher ]) }
  end

  describe 'devise modules' do
    it 'should include expected devise modules' do
      expect(described_class.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :recoverable
      )
    end
  end

  describe 'associations' do
    subject { create(:user) }
    it { should belong_to(:selected_course).class_name('Course') }
    it { should have_many(:course_users).dependent(:destroy) }
    it { should have_many(:courses).through(:course_users) }
  end

  describe 'validations' do
    context 'attributes' do
      subject { build(:user) }

      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:nickname) }
      it { should validate_presence_of(:role) }
    end

    context 'when selected_course is changed' do
      let(:user_with_courses) { create(:user) }
      let(:course2) { create(:course) }
      let(:unrelated_course) { create(:course) }

      before do
        user_with_courses.courses << course2
      end

      it 'is valid if selected_course is one of the user\'s courses' do
        user_with_courses.selected_course = course2
        expect(user_with_courses).to be_valid
      end

      it 'is not valid if selected_course is not one of the user\'s courses' do
        user_with_courses.selected_course = unrelated_course
        expect(user_with_courses).not_to be_valid
        expect(user_with_courses.errors[:selected_course]).to include("must be one of the user's courses")
      end

      it 'does not run validation if selected_course_id did not change' do
        expect(user_with_courses).to be_valid
        expect(user_with_courses.save).to be true
        expect(user_with_courses.errors[:selected_course]).to be_empty
      end
    end
  end

  describe 'callbacks' do
    let!(:default_course) { create(:course, :default_course) }
    describe 'before_validation :assign_default_course, on: :create' do
      let(:new_user) { build(:user, :without_selected_course) }

      it 'finds or creates the default course' do
        expect(Course).to receive(:find_or_create_by!).with(
          name: "Programación 1",
          description: "Curso de Programación 1"
        ).and_call_original
        new_user.save!
      end

      it 'associates the default course with the new user' do
        new_user.save!
        expect(new_user.reload.courses).to include(default_course)
      end

      it 'sets the default course as the selected_course' do
        new_user.save!
        expect(new_user.reload.selected_course).to eq(default_course)
      end

      it 'handles pre-existing default course without creating a new one' do
        expect { new_user.save! }.not_to change(Course, :count)
        expect(new_user.reload.courses).to include(default_course)
        expect(new_user.selected_course).to eq(default_course)
      end
    end
  end
end
