# frozen_string_literal: true

module QuestionTypes
  # Constants for valid question types
  QUESTION_TYPES = %w[correct_output fill_in_the_blank code_analysis recall].freeze

  CORRECT_OUTPUT = <<~CORRECT_OUTPUT
        Fromato de Pregunta: **Salida Correcta**.
        Para generar una pregunta de este tipo, crea un fragmento de código Pascal **conciso y funcional** que ilustre un concepto específico del curso (ej: un bucle `for`, un condicional `if/else`, una llamada a procedimiento/función simple). El fragmento no debe superar las 20 líneas. La pregunta debe requerir que el estudiante **siga la ejecución** de este código (posiblemente manualmente) para determinar el valor de una variable en un punto específico o la salida final del programa. Este formato es útil para practicar el **seguimiento de la ejecución del código**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Salida Correcta.
      CORRECT_OUTPUT

  FILL_IN_THE_BLANK = <<~FILL_IN_THE_BLANK
        Formato de Pregunta: **Relleno de Espacios en Blanco**.
        Para generar una pregunta de este tipo, crea un fragmento de código Pascal completo y funcional. Luego, **elimina deliberadamente una o varias secciones clave** (ej: una palabra clave como `begin`, `end`, `while`, `if`; una condición; una declaración de variable; un operador; una llamada a función/procedimiento) para crear los espacios en blanco. La pregunta debe pedir al estudiante que seleccione la opción que **complete correctamente** el fragmento para que sea sintáctica y semánticamente válido en Pascal. Este formato ayuda a afianzar la **sintaxis y estructura del lenguaje**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Relleno de Espacios en Blanco.
      FILL_IN_THE_BLANK

  CODE_ANALYSIS = <<~CODE_ANALYSIS
        Formato de Pregunta: **Análisis de Código**.
        Para generar una pregunta de este tipo, proporciona un fragmento de código Pascal que contenga (o parezca contener) un **error común** para un principiante de Programación 1 (ej: error de sintaxis, error lógico simple como bucle infinito o condición incorrecta), o que pueda ser **mejorado** (ej: duplicación de código, falta de claridad). La pregunta debe pedir al estudiante que **identifique** el problema, sugiera una **corrección**, o proponga una **mejora** básica. Este tipo fomenta las habilidades de **depuración y crítica de código**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Análisis de Código.
      CODE_ANALYSIS

  RECALL = <<~RECALL
        Formato de Pregunta: **Teórica**.
        Para generar una pregunta de este tipo, formula una pregunta que evalúe la comprensión de **conceptos fundamentales**, **definiciones** o **detalles técnicos específicos** del curso de Programación 1 y el lenguaje Pascal/Free Pascal, según se define en el contexto general del prompt (ej: ¿Qué es una variable? ¿Cuál es el propósito de `writeln`? ¿Cómo funciona la evaluación de circuito corto para `and`?). La pregunta debe requerir código mínimo o nulo. Este formato sirve para reforzar el **vocabulario y la base teórica**.
        Tu tarea es generar una pregunta de Múltiple Opción de tipo Recuerdo.
      RECALL


  QUESTION_TYPE_PROMPTS = {
    "correct_output" => CORRECT_OUTPUT,
    "fill_in_the_blank" => FILL_IN_THE_BLANK,
    "code_analysis" => CODE_ANALYSIS,
    "recall" => RECALL
  }.freeze
end
