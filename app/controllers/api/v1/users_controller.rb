# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def stats
        @stats = current_user.stats
      end
    end
  end
end
