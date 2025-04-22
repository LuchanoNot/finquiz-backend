# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Unit, type: :model do
  let(:unit) { build(:unit) }

  describe 'associations' do
    it { should belong_to(:course) }
  end

  describe 'validations' do
    subject { build(:unit) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:position) }

    it { should validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(1) }

    it 'validates uniqueness of position scoped to course_id' do
      existing_unit = create(:unit)
      new_unit = build(:unit, course: existing_unit.course, position: existing_unit.position)
      expect(new_unit).not_to be_valid
      expect(new_unit.errors[:position]).to include("debe ser único por curso")
    end

    it 'allows different positions for different courses' do
      course1 = create(:course)
      course2 = create(:course)
      create(:unit, course: course1, position: 1)
      unit_for_course2 = build(:unit, course: course2, position: 1)
      expect(unit_for_course2).to be_valid
    end

    it 'is valid with valid attributes' do
      expect(unit).to be_valid
    end
  end
end
