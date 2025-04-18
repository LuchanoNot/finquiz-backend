# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    raise ArgumentError, "user cannot be nil" unless user

    case user.role
    when "student"
      Abilities::StudentAbility.new(user, self)
    when "teacher"
      Abilities::TeacherAbility.new(user, self)
    else
      raise ArgumentError, "Invalid role: #{user.role}"
    end
  end
end
