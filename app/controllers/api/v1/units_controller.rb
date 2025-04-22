# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      before_action :set_unit, only: [ :show ]

      def create
        course = Course.find(params[:course_id])
        authorize! :update, course
        @unit = course.units.new(
          unit_params.merge(position: course.units.maximum(:position).to_i + 1)
        )

        unless @unit.save
          render json: { errors: @unit.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        authorize! :read, @unit
      end

      private

      def set_unit
        @unit = Course.find(params[:course_id])&.units&.find(params[:id])
      end

      def unit_params
        params.require(:unit).permit(:name, :description)
      end
    end
  end
end
