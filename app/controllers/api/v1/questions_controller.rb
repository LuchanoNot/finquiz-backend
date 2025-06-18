# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :set_questionnaire, only: [ :answer ]
      before_action :set_question

      def show
        authorize! :read, @question
      end

      def answer
        authorize! :answer, @question

        ActiveRecord::Base.transaction do
          @option = @question.options.find(params[:answer])

          @questionnaire.questionnaires_questions.find_by(question_id: @question.id).update!(answered_option: @option)
        end
      end

      def vote
        authorize! :read, @question

        vote_action = params[:vote_action]

        case vote_action
        when "up_vote"
          @question.increment!(:score)
        when "report"
          @question.update!(score: -1)
        else
          return render json: { error: "Invalid action" }, status: :bad_request
        end

        render json: @question
      end

      private

      def set_questionnaire
        @questionnaire = Questionnaire.find(params[:questionnaire_id])
      end

      def set_question
        @question = Question.find(params[:id])
      end
    end
  end
end
