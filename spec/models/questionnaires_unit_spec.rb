# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionnairesUnit, type: :model do
  describe 'associations' do
    it { should belong_to(:questionnaire) }
    it { should belong_to(:unit) }
  end
end
