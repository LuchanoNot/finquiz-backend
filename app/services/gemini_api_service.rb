# frozen_string_literal: true

class GeminiApiService
  GEMINI_MODEL = "gemini-2.5-flash-preview-04-17"

  def initialize
    @client = OpenAI::Client.new(
      uri_base: "https://generativelanguage.googleapis.com/v1beta/openai/",
      access_token: ENV["GEMINI_API_KEY"],
    )
  end

  def chat(prompt)
    response = @client.chat(
      parameters: {
        model: GEMINI_MODEL,
        messages: [
          # { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: prompt }
        ]
      }
    )
    parse_response(response)
  end

  def parse_response(response)
    response.dig("choices", 0, "message", "content")
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse response: #{e.message}")
    nil
  end
end
