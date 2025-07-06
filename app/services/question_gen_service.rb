# frozen_string_literal: true

class QuestionGenService
  include SharedUtils
  require "erb"

  PROMPT_VERSION = 2
  PREVIOUS_TOPICS = ENV.fetch("PREVIOUS_TOPICS", "false").present?

  def initialize(client, history, debugger_mode = false)
    @client = client
    @history = history
    @debugger_mode = debugger_mode
  end

  def generate_question(question_type = "correct_output", topic_id = "", complex_response = false)
    @question_type = question_type
    @topic_id = topic_id

    parsed_response = complex_response ? process_complex_response : process_single_prompt

    if @debugger_mode
      puts "STEM: #{parsed_response["question"]}"
      puts "CORRECT ANSWER: #{parsed_response["correctAnswer"]}"
      puts "EXPLANATION: #{parsed_response["explanation"]}"
    end

    {
      question: parsed_response["question"],
      correct_answer: parsed_response["correctAnswer"],
      explanation: parsed_response["explanation"],
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

  def process_complex_response
    if PREVIOUS_TOPICS
      base_response = add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}_with_previous_topics"))
    else
      base_response = add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}"))
    end
    return nil unless base_response

    complex_response = add_prompt(get_prompt_from_file("question/complexer_v1"))
    return nil unless complex_response

    complex_response
  end

  def process_single_prompt
    if PREVIOUS_TOPICS
      add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}_with_previous_topics"))
    else
      add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}"))
    end
  end

  def question_topics_prompt(topic_id)
    Topic.find(topic_id)&.prompt || ""
  end

  def topic_previous_topics_prompt(topic_id)
    Topic.find(topic_id)&.previous_topics_prompt || ""
  end

  def question_type_prompt(topic_id)
    Topic.find(topic_id)&.question_type_prompt || ""
  end
end
