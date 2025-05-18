# frozen_string_literal: true

module SharedUtils
  def add_prompt(prompt)
    return if @history.nil?
    add_to_conversation("user", prompt)
    response = @client.chat(
      parameters: {
        model: ENV["LLM_MODEL"] || "gemini-2.5-pro-preview-03-25",
        messages: @history,
        response_format: {
          type: :json_object
        }
      }
    )

    assistant_message = response.dig("choices", 0, "message", "content")
    add_to_conversation("assistant", assistant_message)

    JSON.parse(assistant_message)
  rescue OpenAI::Error => e
    Rails.logger.error("OpenAI API error: #{e.message}")
    nil
  rescue StandardError => e
    Rails.logger.error("An error occurred: #{e.message}")
    nil
  end

  def add_to_conversation(role, content)
    return if @history.nil?
    @history << { role: role, content: content }
  end

  def get_prompt_from_file(file_name)
    file_path = Rails.root.join("app", "services", "prompts", "#{file_name}.md")
    ERB.new(File.read(file_path)).result(binding)
  end
end
