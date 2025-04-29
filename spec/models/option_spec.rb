# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:option) { build(:option) }

  describe 'associations' do
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:explanation) }
  end

  describe 'valid option' do
    it 'is valid with valid attributes' do
      expect(option).to be_valid
    end
  end

  describe 'scope' do
    describe '#correct' do
      before do
        create(:option, correct: true)
        create(:option, correct: false)
      end

      it 'returns the correct options' do
        expect(Option.correct).to eq(Option.where(correct: true))
      end
    end
  end
end
