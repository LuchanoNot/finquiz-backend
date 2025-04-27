# frozen_string_literal: true

class MCQGenerationService
  def initialize
    @client = OpenAI::Client.new
    @history = []
  end

  def generate_complete_question(question_type = "code_analysis", question_topics = "")
    # Step 1: Generate the question and correct answer
    question_result = QuestionGenService.new(client: @client, history: @history).generate_question(
      question_type,
      question_topics,
      true
    )

    return nil if question_result.nil?

    @history = question_result[:history]

    # Step 2: Generate distractors
    distractors_result = DistractorsGenService.new(
      client: @client,
      history: @history
    ).generate_distractors(
      question_result[:question],
      question_result[:correct_answer],
      true
    )

    return nil if distractors_result.nil?

    # Step 3: Combine all the results
    {
      question: question_result[:question],
      correct_answer: question_result[:correct_answer],
      distractors: distractors_result[:distractors],
      explanation: question_result[:explanation]
    }
  end

  def compare_with_and_without_chain_of_thought(question_type = "code_analysis", question_topics = "")
    question_result = QuestionGenService.new(client: @client, history: @history).generate_question(
      question_type,
      question_topics,
      true
    )

    return nil if question_result.nil?

    # Store the question and correct answer
    question = question_result[:question]
    correct_answer = question_result[:correct_answer]
    explanation = question_result[:explanation]

    # Step 2: Generate distractors with chain of thought
    @history = question_result[:history]
    with_chain_of_thought_distractors = DistractorsGenService.new(
      client: @client,
      history: @history
    ).generate_distractors(
      question,
      correct_answer,
      true
    )

    return nil if with_chain_of_thought_distractors.nil?

    # Step 3: Generate distractors without chain of thought
    @history = question_result[:history]
    without_chain_of_thought_distractors = DistractorsGenService.new(
      client: @client,
      history: @history
    ).generate_distractors(
      question,
      correct_answer,
      false
    )

    return nil if without_chain_of_thought_distractors.nil?

    {
      question: question,
      correct_answer: correct_answer,
      explanation: explanation,
      with_chain_of_thought: {
        distractors: with_chain_of_thought_distractors[:distractors]
      },
      without_chain_of_thought: {
        distractors: without_chain_of_thought_distractors[:distractors]
      }
    }
  end
end
