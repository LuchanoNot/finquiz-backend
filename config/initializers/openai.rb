# frozen_string_literal: true

OpenAI.configure do |config|
  config.uri_base = "https://generativelanguage.googleapis.com/v1beta/openai/"
  config.access_token = ENV["GEMINI_API_KEY"]
end
