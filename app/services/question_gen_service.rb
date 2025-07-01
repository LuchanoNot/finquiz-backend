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

  def question_type_prompt(question_type)
    case question_type
    when "correct_output"
      <<~CORRECT_OUTPUT
        Fromato de Pregunta: **Salida Correcta**.
        Para generar una pregunta de este tipo, crea un fragmento de código Pascal **conciso y funcional** que ilustre un concepto específico del curso (ej: un bucle `for`, un condicional `if/else`, una llamada a procedimiento/función simple). El fragmento no debe superar las 20 líneas. La pregunta debe requerir que el estudiante **siga la ejecución** de este código (posiblemente manualmente) para determinar el valor de una variable en un punto específico o la salida final del programa. Este formato es útil para practicar el **seguimiento de la ejecución del código**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Salida Correcta.
      CORRECT_OUTPUT
    when "fill_in_the_blank"
      <<~FILL_IN_THE_BLANK
        Formato de Pregunta: **Relleno de Espacios en Blanco**.
        Para generar una pregunta de este tipo, crea un fragmento de código Pascal completo y funcional. Luego, **elimina deliberadamente una o varias secciones clave** (ej: una palabra clave como `begin`, `end`, `while`, `if`; una condición; una declaración de variable; un operador; una llamada a función/procedimiento) para crear los espacios en blanco. La pregunta debe pedir al estudiante que seleccione la opción que **complete correctamente** el fragmento para que sea sintáctica y semánticamente válido en Pascal. Este formato ayuda a afianzar la **sintaxis y estructura del lenguaje**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Relleno de Espacios en Blanco.
      FILL_IN_THE_BLANK
    when "code_analysis"
      <<~CODE_ANALYSIS
        Formato de Pregunta: **Análisis de Código**.
        Para generar una pregunta de este tipo, proporciona un fragmento de código Pascal que contenga (o parezca contener) un **error común** para un principiante de Programación 1 (ej: error de sintaxis, error lógico simple como bucle infinito o condición incorrecta), o que pueda ser **mejorado** (ej: duplicación de código, falta de claridad). La pregunta debe pedir al estudiante que **identifique** el problema, sugiera una **corrección**, o proponga una **mejora** básica. Este tipo fomenta las habilidades de **depuración y crítica de código**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Análisis de Código.
      CODE_ANALYSIS
    when "recall"
      <<~RECALL
        Formato de Pregunta: **Teórica**.
        Para generar una pregunta de este tipo, formula una pregunta que evalúe la comprensión de **conceptos fundamentales**, **definiciones** o **detalles técnicos específicos** del curso de Programación 1 y el lenguaje Pascal/Free Pascal, según se define en el contexto general del prompt (ej: ¿Qué es una variable? ¿Cuál es el propósito de `writeln`? ¿Cómo funciona la evaluación de circuito corto para `and`?). La pregunta debe requerir código mínimo o nulo. Este formato sirve para reforzar el **vocabulario y la base teórica**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Recuerdo.
      RECALL
    else
      "Generate a question."
    end
  end
end
