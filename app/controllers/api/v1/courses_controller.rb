# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: [ :show, :update, :reports ]

      def show
        authorize! :read, @course
      end

      def update
        authorize! :update, @course

        unless @course.update(course_params)
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def reports
        authorize! :reports, @course

        @students = @course.students.order(:name).page(params[:page] || 1)
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :description)
      end
    end
  end
end
