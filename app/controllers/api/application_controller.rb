# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate_api_v1_user!
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

    def record_not_found(exception)
      render json: { error: exception.message }, status: :not_found
    end
  end
end
