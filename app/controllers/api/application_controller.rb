# frozen_string_literal: true

module Api
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
  end
end
