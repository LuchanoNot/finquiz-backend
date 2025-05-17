# frozen_string_literal: true

module Api
  module V1
    class QuestionnairesController < ApplicationController
      before_action :set_questionnaire

      def show
        authorize! :read, @questionnaire
      end

      private

      def set_questionnaire
        @questionnaire = Questionnaire.find(params[:id])
      end
    end
  end
end
