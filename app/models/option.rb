# frozen_string_literal: true

class Option < ActiveRecord::Base
  belongs_to :question

  validates :text, :explanation, presence: true
end
