# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate_api_v1_user!
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def current_user
      current_api_v1_user
    end

    private

    def record_not_found(exception)
      render json: { errors: [ exception.message ] }, status: :not_found
    end

    def record_invalid(exception)
      render json: { errors: [ exception.message ] }, status: :unprocessable_entity
    end
  end
end
