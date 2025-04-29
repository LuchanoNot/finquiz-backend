# frozen_string_literal: true

class QuestionGenService
  require "erb"

  GEMINI_MODEL = "gemini-2.5-pro-preview-03-25"
  PROMPT_VERSION = 1

  def initialize(client:, history:)
    @client = client
    @history = history
  end

  def generate_question(question_type = "correct_output", question_topics = "", debugger_mode = true)
    path = Rails.root.join("app", "services", "prompts", "question", "question_gen_v#{PROMPT_VERSION}.md")
    prompt = ERB.new(File.read(path)).result(binding)

    @history = [
      {
        role: "system",
        content: "Soy un asistente basado en Gemini 2.5 pro para estudiantes de Ingeniería en Computación cursando Programación 1. Mi tarea es crear preguntas de múltiple opción de alta calidad que sirvan como herramienta de estudio y autoevaluación informal para que los alumnos refuercen su comprensión de los temas."
      },
      {
        role: "user",
        content: prompt
      }
    ]

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

    @history << { role: "assistant", content: assistant_message }

    parsed_response = JSON.parse(assistant_message)

    if debugger_mode
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

  def question_topics_prompt(question_topics)
    <<~QUESTION_TOPIC
      La pregunta generada debe estar relacionada con el tema **"Funciones estándar y conversiones de tipo"**, que abarca:

      - Funciones integradas como `sqr`, `sqrt`, `trunc`, `round` y `abs`.
      - Manipulación de caracteres con `ord` y `chr`.
    QUESTION_TOPIC
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

  def parse_response(response)
    response.dig("choices", 0, "message", "content")
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse response: #{e.message}")
    nil
  end
end
