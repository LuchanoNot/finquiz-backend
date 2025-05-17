# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:question) { create(:question) }
  let(:option) { build(:option, question: question) }

  describe 'associations' do
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:explanation) }

    describe 'only_one_correct_answer_per_question' do
      it 'should allow creating one correct option per question' do
        expect { create(:option, correct: true, question: question) }.not_to raise_error
      end

      it 'should raise an error when creating a second correct option for the same question' do
        create(:option, correct: true, question: question)

        expect { create(:option, correct: true, question: question) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
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
