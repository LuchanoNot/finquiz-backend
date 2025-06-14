# frozen_string_literal: true

class MCQGenerationService
  def initialize(debugger_mode = false)
    @client = OpenAI::Client.new
    @history = [ {
      role: "system",
      content: "Eres un asistente para estudiantes de Ingeniería en Computación cursando Programación 1. Tu tarea es crear preguntas de múltiple opción de alta calidad que sirvan como herramienta de estudio y autoevaluación informal para que los alumnos refuercen su comprensión de los temas."
    } ]
    @debugger_mode = debugger_mode
  end

  def generate_complete_question(question_type: "correct_output", topic_id: "")
    # Step 1: Generate the question and correct answer
    question_result = QuestionGenService.new(@client, @history, @debugger_mode).generate_question(
      question_type,
      topic_id,
    )

    return nil if question_result.nil?

    @history = question_result[:history]

    # Step 2: Generate distractors
    distractors_result = DistractorsGenService.new(@client, @history, @debugger_mode).generate_distractors(
      question_result[:question],
      question_result[:correct_answer],
      true,
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

  def compare_with_and_without_chain_of_thought(question_type: "correct_output", topic_id: "")
    question_result = QuestionGenService.new(@client, @history, @debugger_mode).generate_question(
      question_type,
      topic_id,
    )

    return nil if question_result.nil?

    # Store the question and correct answer
    question = question_result[:question]
    correct_answer = question_result[:correct_answer]
    explanation = question_result[:explanation]

    # Step 2: Generate distractors with chain of thought
    @history = question_result[:history]
    with_chain_of_thought_distractors = DistractorsGenService.new(
      @client,
      @history,
      @debugger_mode
    ).generate_distractors(
      question,
      correct_answer,
      true,
    )

    return nil if with_chain_of_thought_distractors.nil?

    # Step 3: Generate distractors without chain of thought
    @history = question_result[:history]
    without_chain_of_thought_distractors = DistractorsGenService.new(
      @client,
      @history,
      @debugger_mode
    ).generate_distractors(
      question,
      correct_answer,
      false,
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
