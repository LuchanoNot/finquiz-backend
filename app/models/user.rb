# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User

  enum :role, [ :student, :teacher ]

  validates :email, :password, :name, :nickname, :role, presence: true, on: :create
  validates :email, uniqueness: true
  validates :role, presence: true
end
