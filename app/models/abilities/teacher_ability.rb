# frozen_string_literal: true

module Abilities
  class TeacherAbility
    include CanCan::Ability

    def initialize(user, ability)
      @user = user
      @ability = ability

      courses_policy
    end

    private

    def courses_policy
      @ability.can [ :read, :update ], Course, users: { id: @user.id }
    end
  end
end
