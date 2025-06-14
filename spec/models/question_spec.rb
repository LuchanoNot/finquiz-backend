# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { should have_many(:options).dependent(:destroy) }
  end

  describe 'validations' do
    let(:question) { create(:question) }
    it { should validate_presence_of(:stem) }
    it { should validate_presence_of(:score) }

    context 'when options are valid' do
      it 'is valid with exactly one correct option and four options' do
        expect(question).to be_valid
      end
    end
  end

  describe 'correct_option' do
    context 'when there is a correct option' do
      let(:question) { create(:question, :with_options) }

      it 'returns the correct option' do
        expect(question.correct_option).to eq(question.options.correct.first)
      end
    end

    context 'when there is no correct option' do
      let(:question) { create(:question) }

      it 'returns nil' do
        expect(question.correct_option).to be_nil
      end
    end
  end
end
