# frozen_string_literal: true

module Api
  module V1
    class QuestionnairesController < ApplicationController
      before_action :set_questionnaire, only: [ :show, :summary ]

      def index
        @questionnaires = current_user.questionnaires.order(created_at: :desc)
      end

      def show
        authorize! :read, @questionnaire
      end

      # Por defecto se generan 5 preguntas, por ahora
      def create
        authorize! :create, Questionnaire

        @questionnaire = Questionnaire.create!(questionnaire_params)

        5.times do |i|
          @questionnaire.questions.create!(stem: "GENERATING QUESTION", generating: true)
        end

        GenerateQuestionsJob.perform_later(@questionnaire.id)
      end

      def summary
        authorize! :summary, @questionnaire

        render status: :unprocessable_entity unless @questionnaire.is_completed?
      end

      private

      def set_questionnaire
        @questionnaire = Questionnaire.find(params[:id])
      end

      def questionnaire_params
        params.require(:questionnaire).permit(:name, :user_id, units_ids: [])
      end
    end
  end
end
