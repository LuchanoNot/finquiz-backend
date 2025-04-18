# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { build(:course) }

  describe 'associations' do
    it { should have_many(:course_users).dependent(:destroy) }
    it { should have_many(:users).through(:course_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:description) }

    it 'is valid with valid attributes' do
      expect(course).to be_valid
    end

    it 'is not valid without a name' do
      course.name = nil
      expect(course).not_to be_valid
      expect(course.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is not valid without a description' do
      course.description = nil
      expect(course).not_to be_valid
      expect(course.errors[:description]).to include("no puede estar en blanco")
    end
  end
end
