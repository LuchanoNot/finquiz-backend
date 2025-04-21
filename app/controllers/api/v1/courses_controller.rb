# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: [ :show ]

      def show; end

      private

      def set_course
        @course = Course.find(params[:id])
      end
    end
  end
end
