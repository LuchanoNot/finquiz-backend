# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  describe 'associations' do
    it { should have_many(:questionnaires_questions).dependent(:destroy) }
    it { should have_many(:questions).through(:questionnaires_questions) }

    it { should have_many(:questionnaires_units).dependent(:destroy) }
    it { should have_many(:units).through(:questionnaires_units) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
