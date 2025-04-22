# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      before_action :set_unit, only: [ :show, :update ]

      def create
        @course = Course.find(params[:course_id])
        authorize! :update, @course

        reorder_and_create(unit_params[:position].to_i)
      end

      def show
        authorize! :read, @unit
      end

      def update
        authorize! :update, @unit

        if unit_params[:position].blank? || unit_params[:position].to_i == @unit.position
          return @unit.update!(unit_params)
        end

        reorder_and_update(unit_params[:position].to_i)
      end

      private

      def set_unit
        @unit = Course.find(params[:course_id])&.units&.find(params[:id])
      end

      def unit_params
        params.require(:unit).permit(:name, :description, :position)
      end

      def reorder_and_create(new_position)
        ActiveRecord::Base.transaction do
          @course.units
            .where("position >= ?", new_position)
            .update_all("position = position + 1")

          @unit = @course.units.create!(unit_params)
        end
      end

      def reorder_and_update(new_position)
        old_position = @unit.position

        ActiveRecord::Base.transaction do
          if new_position > old_position
            @unit.course.units
              .where("position > ? AND position <= ?", old_position, new_position)
              .update_all("position = position - 1")
          elsif new_position < old_position
            @unit.course.units
              .where("position >= ? AND position < ?", new_position, old_position)
              .update_all("position = position + 1")
          end

          @unit.update!(unit_params)
        end
      end
    end
  end
end
