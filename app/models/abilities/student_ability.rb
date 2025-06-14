# frozen_string_literal: true

module Abilities
  class StudentAbility
    include CanCan::Ability

    def initialize(user, ability)
      @user = user
      @ability = ability

      courses_policy
      questionnaires_policy
      questions_policy
    end

    private

    def courses_policy
      @ability.can :read, Course, users: { id: @user.id }
    end

    def questionnaires_policy
      @ability.can [ :read, :create, :summary ], Questionnaire, user: @user
    end

    def questions_policy
      @ability.can [ :read, :answer ], Question, questionnaires_questions: { questionnaire: { user: @user } }
    end
  end
end
