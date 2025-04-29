# frozen_string_literal: true

json.id @question.id

json.extract! @option, :explanation, :correct
