# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      before_action :set_unit, only: [ :show ]

      def show; end

      private

      def set_unit
        @unit = Course.find(params[:course_id])&.units&.find(params[:id])
      end
    end
  end
end
