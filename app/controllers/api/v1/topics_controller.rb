# frozen_string_literal: true

module Api
  module V1
    class TopicsController < ApplicationController
      before_action :set_unit
      before_action :set_topic, only: [ :update, :destroy ]

      def create
        authorize! :update, @unit

        @topic = @unit.topics.create!(topic_params)
      end

      def update
        authorize! :update, @topic

        @topic.update!(topic_params)
      end

      def destroy
        authorize! :update, @topic
        @topic.destroy!
      end

      private

      def set_unit
        @unit = Unit.find(params[:unit_id])
      end

      def set_topic
        @topic = @unit.topics.find(params[:id])
      end

      def topic_params
        params.require(:topic).permit(:name, :description, :short_description, :notes)
      end
    end
  end
end
