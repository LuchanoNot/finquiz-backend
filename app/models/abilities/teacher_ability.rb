# frozen_string_literal: true

module Abilities
  class TeacherAbility
    include CanCan::Ability

    def initialize(user, ability)
      @user = user
      @ability = ability

      courses_policy
      units_policy
    end

    private

    def courses_policy
      @ability.can [ :read, :update ], Course, users: { id: @user.id }
    end

    def units_policy
      @ability.can [ :read, :update ], Unit, course: { users: { id: @user.id } }
    end
  end
end
