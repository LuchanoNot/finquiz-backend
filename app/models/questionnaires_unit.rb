# frozen_string_literal: true

class QuestionnairesUnit < ApplicationRecord
  belongs_to :unit
  belongs_to :questionnaire
end
