# frozen_string_literal: true

module Abilities
  class TeacherAbility
    include CanCan::Ability

    def initialize(user, ability)
      @user = user
      @ability = ability

      # Define abilities for the teacher role
    end
  end
end
