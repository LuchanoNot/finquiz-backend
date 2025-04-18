# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate_api_v1_user!
  end
end
