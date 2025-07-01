# frozen_string_literal: true

OpenAI.configure do |config|
  config.uri_base = ENV.fetch(
    "LLM_URI_BASE",
    "https://generativelanguage.googleapis.com/v1beta/openai/"
  )
  config.access_token =
    if ENV["LLM_SERVICE"] == "openai"
      ENV["OPEN_AI_KEY"]
    else
      ENV["GEMINI_API_KEY"]
    end
end
