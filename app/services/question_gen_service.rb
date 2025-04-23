# frozen_string_literal: true

class QuestionGenService
  require "erb"

  GEMINI_MODEL = "gemini-2.5-flash-preview-04-17"
  PROMPT_VERSION = 0

  def initialize
    @client = OpenAI::Client.new(
      uri_base: "https://generativelanguage.googleapis.com/v1beta/openai/",
      access_token: ENV["GEMINI_API_KEY"],
    )
  end

  def generate_question(question_type = "code_analysis", question_topics = "", debugger_mode = true)
    path = Rails.root.join("app", "services", "prompts", "question_gen_v#{PROMPT_VERSION}.md")
    prompt = ERB.new(File.read(path)).result(binding)

    response = @client.chat(
      parameters: {
        model: GEMINI_MODEL,
        messages: [
          { role: "system", content: "Eres un experto asistente para estudiantes de ingeniería en computación enfocado en la creación de evaluaciones de múltiple opción de alta calidad para el curso de Programación 1!" },
          { role: "user", content: prompt }
        ],
        response_format: {
          type: :json_object
        }
      }
    )

    parsed_response = JSON.parse(response.dig("choices", 0, "message", "content"))

    if debugger_mode
      puts "STEM: #{parsed_response["question"]}"
      puts "CORRECT ANSWER: #{parsed_response["correctAnswer"]}"
      puts "EXPLANATION: #{parsed_response["explanation"]}"
    else
      parsed_response
    end

  rescue OpenAI::Error => e
    Rails.logger.error("OpenAI API error: #{e.message}")
    nil
  rescue StandardError => e
    Rails.logger.error("An error occurred: #{e.message}")
    nil
  end

  def question_topics_prompt(question_topics)
    <<~QUESTION_TOPIC
      La pregunta que generes debe estar relacionada con el tema **"Funciones estándar y conversiones de tipo"**, que abarca:

      - Funciones integradas como `sqr`, `sqrt`, `trunc`, `round` y `abs`.
      - Manipulación de caracteres con `ord` y `chr`.
    QUESTION_TOPIC
  end

  def question_type_prompt(question_type)
    case question_type
    when "code_analysis"
      <<~CODE_ANALYSIS
        Una pregunta de múltiple opción del tipo **Salida Correcta** proporciona un fragmento de código y solicita a los estudiantes que sigan la ejecución del programa para determinar una salida intermedia o final. Este tipo de pregunta debe ayudar a comprender el proceso de ejecución del código mientras contiene conocimientos específicos del contenido del curso.
        Este es el tipo de pregunta que debes generar.
      CODE_ANALYSIS
    else
      "Generate a question."
    end
  end

  def parse_response(response)
    message_content = response.dig("choices", 0, "message", "content")
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse response: #{e.message}")
    nil
  end
end
