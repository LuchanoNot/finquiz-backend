# frozen_string_literal: true

class QuestionGenService
  include SharedUtils
  require "erb"

  PROMPT_VERSION = 2

  def initialize(client, history, debugger_mode = false)
    @client = client
    @history = history
    @debugger_mode = debugger_mode
  end

  def generate_question(question_type = "correct_output", question_topics = "", complex_response = false)
    @question_type = question_type
    @question_topics = question_topics

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
    base_response = add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}"))
    return nil unless base_response

    complex_response = add_prompt(get_prompt_from_file("question/complexer_v1"))
    return nil unless complex_response

    complex_response
  end

  def process_single_prompt
    add_prompt(get_prompt_from_file("question/question_gen_v#{PROMPT_VERSION}"))
  end

  def question_topics_prompt(question_topics)
    <<~QUESTION_TOPIC
      La pregunta generada debe estar relacionada con el tema **"Funciones estándar y conversiones de tipo"**, que abarca:

      - Funciones integradas como `sqr`, `sqrt`, `trunc`, `round` y `abs`.
      - Manipulación de caracteres con `ord` y `chr`.

      Nota: En caso de necesitarlo, ten en cuenta que las equivalencias entre caracteres y enteros utilizando ASCII son:
      | Código | Carácter |
      |---|---|
      | 048 | 0 |
      | 049 | 1 |
      | 050 | 2 |
      | 051 | 3 |
      | 052 | 4 |
      | 053 | 5 |
      | 054 | 6 |
      | 055 | 7 |
      | 056 | 8 |
      | 057 | 9 |
      | 058 | : |
      | 059 | ; |
      | 060 | < |
      | 061 | = |
      | 062 | > |
      | 063 | ? |
      | 064 | @ |
      | 065 | A |
      | 066 | B |
      | 067 | C |
      | 068 | D |
      | 069 | E |
      | 070 | F |
      | 071 | G |
      | 072 | H |
      | 073 | I |
      | 074 | J |
      | 075 | K |
      | 076 | L |
      | 077 | M |
      | 078 | N |
      | 079 | O |
      | 080 | P |
      | 081 | Q |
      | 082 | R |
      | 083 | S |
      | 084 | T |
      | 085 | U |
      | 086 | V |
      | 087 | W |
      | 088 | X |
      | 089 | Y |
      | 090 | Z |
      | 097 | a |
      | 098 | b |
      | 099 | c |
      | 100 | d |
      | 101 | e |
      | 102 | f |
      | 103 | g |
      | 104 | h |
      | 105 | i |
      | 106 | j |
      | 107 | k |
      | 108 | l |
      | 109 | m |
      | 110 | n |
      | 111 | o |
      | 112 | p |
      | 113 | q |
      | 114 | r |
      | 115 | s |
      | 116 | t |
      | 117 | u |
      | 118 | v |
      | 119 | w |
      | 120 | x |
      | 121 | y |
      | 122 | z |
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
end
