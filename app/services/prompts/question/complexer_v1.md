# Complejizar Pregunta Multiple Opción

**Objetivo:** Dado el enunciado y la respuesta correcta de una pregunta de opción múltiple (MCQ) generada anteriormente, aumentar su dificultad a un nivel universitario asegurando que la respuesta correcta original siga siendo válida y el tema de la pregunta. Si aumentar la dificultad manteniendo la respuesta correcta no es factible, indicar que no es posible modificarla.

## **Tema de la Pregunta:**

<%= question_topics_prompt(@topic_id) %>

# **Proceso de Razonamiento:**

1.  Analizar el enunciado de la pregunta y la respuesta correcta proporcionados.
2.  Reescribir el enunciado de la pregunta para que sea más desafiante, adecuado para una evaluación de nivel universitario. Esto podría implicar:
  *   Introducir escenarios o contextos más complejos.
  *   Requerir una comprensión o aplicación más profunda de los conceptos.
  *   Incluir elementos que requieran análisis crítico y eviten que la respuesta correcta sea obvia.
  *   Añadir matices sutiles evitando (asegurando que la respuesta original siga siendo la única correcta).
3.  Asegurar que la respuesta correcta original siga siendo la única mejor respuesta a la pregunta revisada.
4. Asegurate de que la respuesta original se mantenga como la única respuesta correcta a la pregunta revisada.
5.  Si es posible realizar la modificación, devolver un JSON con el siguiente formato, evitando incluir comentarios en el código:
  ```json
  {
    "question": "El enunciado revisado de la pregunta",
    "correctAnswer": "La respuesta correcta para la pregunta original",
    "explanation": "La explicación de la respuesta correcta *en español* adaptada al nuevo enunciado"
  }
  ```
4.  Si la pregunta no puede ser complejizada razonablemente a un nivel universitario manteniendo la respuesta original correcta, indicar "No es posible modificar".

