# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe '#initialize' do
    let(:student) { create(:user, role: 'student') }
    let(:teacher) { create(:user, role: 'teacher') }

    context 'when user is a student' do
      it 'initializes with StudentAbility' do
        expect(Abilities::StudentAbility).to receive(:new).with(student, instance_of(Ability))
        described_class.new(student)
      end
    end

    context 'when user is a teacher' do
      it 'initializes with TeacherAbility' do
        expect(Abilities::TeacherAbility).to receive(:new).with(teacher, instance_of(Ability))
        described_class.new(teacher)
      end
    end

    context 'when user is nil' do
      it 'raises an ArgumentError' do
        expect { described_class.new(nil) }.to raise_error(ArgumentError, 'user cannot be nil')
      end
    end

    context 'when user has an invalid role' do
      let(:invalid_user) { create(:user, role: 'invalid_role') }

      it 'raises an ArgumentError' do
        expect do
          described_class.new(invalid_user)
        end.to raise_error(ArgumentError, "'invalid_role' is not a valid role")
      end
    end
  end
end
