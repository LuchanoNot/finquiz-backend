# frozen_string_literal: true

class DistractorsGenService
  require "erb"

  GEMINI_MODEL = "gemini-2.5-pro-preview-03-25"
  PROMPT_VERSION = 0

  def initialize(client, history, debugger_mode = false)
    @client = client
    @history = history
    @debugger_mode = debugger_mode
  end

  def generate_distractors(question, correct_answer, chain_of_thought = true)
    parsed_response = chain_of_thought ? process_chain_of_thought : process_single_prompt

    if @debugger_mode
      puts "DISTRACTORS: #{parsed_response["distractors"]}"
    end

    {
      distractors: parsed_response["distractors"],
      history: @history
    }

  rescue OpenAI::Error => e
    Rails.logger.error("OpenAI API error: #{e.message}")
    nil
  rescue StandardError => e
    Rails.logger.error("An error occurred: #{e.message}")
    nil
  end

  private

  def process_chain_of_thought
    base_response = add_prompt(get_prompt_from_file("base"))
    return nil unless base_response

    evaluation_response = add_prompt(get_prompt_from_file("evaluation"))
    return nil unless evaluation_response

    filtering_response = add_prompt(get_prompt_from_file("filtering"))
    return nil unless filtering_response

    selection_response = add_prompt(get_prompt_from_file("selection"))
    return nil unless selection_response

    selection_response
  end

  def process_single_prompt
    add_prompt(get_prompt_from_file("distractors_gen_v#{PROMPT_VERSION}"))
  end

  def add_prompt(prompt)
    add_to_conversation("user", prompt)

    response = @client.chat(
      parameters: {
        model: GEMINI_MODEL,
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
    @history << { role: role, content: content }
  end

  def get_prompt_from_file(filename)
    path = Rails.root.join("app", "services", "prompts", "distractors", "#{filename}.md")
    ERB.new(File.read(path)).result(binding)
  end
end
