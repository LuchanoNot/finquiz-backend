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

      def create
        authorize! :create, Questionnaire

        @questionnaire = current_user.questionnaires.create!(questionnaire_params)
        unit_topics = @questionnaire.units.includes(:topics).flat_map(&:topics).uniq
        unit_topics_count = unit_topics.size

        # Determine number of questions per topic based on topic count
        questions_per_topic = case unit_topics_count
        when 0..3 then 3
        when 4..6 then 2
        else 1
        end

        unit_topics.each do |unit_topic|
          questions_per_topic.times do
            @questionnaire.questions.create!(stem: "GENERATING QUESTION", generating: true, topic: unit_topic)
          end
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
        params.permit(unit_ids: [])
      end
    end
  end
end
