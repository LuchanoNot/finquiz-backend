# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: [ :show ]

      def show; end

      private

      def set_course
        @course = Course.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Course not found" }, status: :not_found
      end
    end
  end
end
