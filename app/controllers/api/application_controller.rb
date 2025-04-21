# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate_api_v1_user!
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def current_user
      current_api_v1_user
    end

    private

    def record_not_found(exception)
      render json: { errors: [ exception.message ] }, status: :not_found
    end
  end
end
