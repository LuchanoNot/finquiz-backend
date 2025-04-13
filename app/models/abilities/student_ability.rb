# frozen_string_literal: true

module Abilities
  class StudentAbility
    include CanCan::Ability

    def initialize(user, ability)
      @user = user
      @ability = ability

      # Define abilities for the student role
    end
  end
end
