# frozen_string_literal: true

class DistractorsGenService
  include SharedUtils
  require "erb"

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
    base_response = add_prompt(get_prompt_from_file("distractors/base"))
    return nil unless base_response

    evaluation_response = add_prompt(get_prompt_from_file("distractors/evaluation"))
    return nil unless evaluation_response

    filtering_response = add_prompt(get_prompt_from_file("distractors/filtering"))
    return nil unless filtering_response

    selection_response = add_prompt(get_prompt_from_file("distractors/selection"))
    return nil unless selection_response

    selection_response
  end

  def process_single_prompt
    add_prompt(get_prompt_from_file("distractors/distractors_gen_v#{PROMPT_VERSION}"))
  end
end
