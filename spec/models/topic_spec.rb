# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { build(:topic) }

  describe 'associations' do
    it { should belong_to(:unit) }
  end

  describe 'validations' do
    subject { build(:topic) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:short_description) }

    it 'is valid with valid attributes' do
      expect(topic).to be_valid
    end
  end
end
