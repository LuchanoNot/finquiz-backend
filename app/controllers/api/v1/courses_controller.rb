# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: [ :show, :update, :reports, :questions_csv ]

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

      def questions_csv
        authorize! :export, @course

        unless params[:format] == "csv" || request.format.csv?
          render json: {
            error: "This endpoint only supports CSV format."
          }, status: :not_acceptable
          return
        end

        csv_data = @course.questions_csv_data
        send_data csv_data,
                 filename: "course_#{@course.id}_questions_#{Date.current.strftime('%Y%m%d')}.csv",
                 type: "text/csv; charset=utf-8"
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
