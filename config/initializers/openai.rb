# frozen_string_literal: true

OpenAI.configure do |config|
  config.uri_base = ENV["LLM_URI_BASE"] || "https://generativelanguage.googleapis.com/v1beta/openai/"
  config.access_token = ENV["LLM_SERVICE"] == "openai" ? ENV["OPEN_AI_KEY"] : ENV["GEMINI_API_KEY"]
end
