## **Contexto del Curso**

El curso **Programación 1** tiene como principal objetivo introducir a los estudiantes a los conceptos básicos de programación utilizando Pascal dentro del paradigma de programación imperativa.

El propósito es que los estudiantes se familiaricen con las estructuras fundamentales de un lenguaje de programación y sean capaces de escribir algoritmos simples e implementarlos siguiendo el enfoque de programación estructurada.

Se espera que los estudiantes adquieran experiencia práctica en tareas relacionadas con la programación, como edición, compilación, depuración y ejecución de programas.

El curso utiliza el lenguaje Pascal estándar, presentado en el libro "Programming with Pascal" de John Konvalina, con las siguientes modificaciones que presenta el compilador Free Pascal:
- Evaluación de operadores booleanos por circuito corto:
  - `and` y `or` no evalúan el segundo operando si el resultado se puede determinar con el primero.
- Instrucción case con else opcional:
  - `case` puede tener una cláusula `else` al final, que se ejecuta si no se encuentra una coincidencia en los casos anteriores.
- Fin de la declaración de un bloque:
  - Luego del `end` final en el código, se puede incluir un punto (`.`) para indicar el final del programa.

## **Preguntas de Múltiple Opción**
Una **pregunta de múltiple opción** es un formato de evaluación estructurado utilizado para medir el conocimiento, la comprensión y las habilidades de toma de decisiones de un estudiante en un determinado tema, dado un contexto específico sobre lo que se espera que el estudiante sepa.

Una pregunta de múltiple opción consta de tres componentes:

- Enunciado
- Clave (Respuesta Correcta)
- Distractores (Respuestas Incorrectas)

### **Definición para un buen Enunciado**

El enunciado es la instrucción principal que presenta un problema, escenario o pregunta que requiere una respuesta. Debe cumplir con las siguientes características:

- **Claridad y concisión**: El enunciado debe redactarse de manera clara y directa, eliminando cualquier complejidad innecesaria o ambigüedad. Evita incluir código que supere las 30 líneas.
- **Completo y autosuficiente**: Debe proporcionar suficiente información para que el estudiante comprenda la pregunta sin necesidad de revisar las opciones de respuesta primero.
- **Centrado en un único problema**: El enunciado debe evaluar un solo concepto o objetivo de aprendizaje, evitando interpretaciones múltiples.
- **Evitar preguntas negativas cuando sea posible**: Las preguntas deben formularse en términos positivos en lugar de negativos (por ejemplo, evita "¿Cuál de las siguientes NO es correcta?"). Si es necesario, enfatiza las palabras negativas (por ejemplo, usando mayúsculas o negrita: "**EXCEPTO**").

### **Definición para una buena Clave (Respuesta Correcta)**

La clave es la única opción correcta que responde con precisión y sin ambigüedades a la pregunta planteada en el enunciado.

## **Tema de la Pregunta**

<%= question_topics_prompt(@topic_id) %>

## **Formato de la Pregunta**

<%= question_type_prompt(@topic_id) %>

## **Formato de Salida**

Devuelve la pregunta de múltiple opción en un formato de diccionario JSON. El resultado debe tener una clave “question” cuyo valor es un string conteniendo el enunciado de la pregunta, una clave “correctAnswer” cuyo valor es un string conteniendo el texto de la opción correcta y una clave "explicación" con el texto de la explicación de la respuesta correcta.

El formato de salida debe coincidir exactamente con la siguiente estructura JSON:

{
  "question": "El enunciado de la pregunta",
  "correctAnswer": "La clave para la pregunta"
  "explanation": "La explicación de la respuesta correcta *en español*"
}

Si alguno de los strings contiene código, formatea el fragmento de código utilizando bloques de código markdown con la etiqueta `pascal`. Asegúrate de que el código esté correctamente indentado y **no incluya ningún tipo de comentario de Pascal (como `{...}` o `//`) ni texto explicativo adicional dentro del bloque de código**:

```pascal
program Hello;
begin
  writeln ('Hello, world.');
end.
```

# **Proceso de Razonamiento**

Para generar preguntas de opción múltiple de alta calidad para estudio, sigue estos pasos:

1.  **Comprensión del Tema**: Analiza el **tema de la pregunta** y asegúrate de entenderlo completamente en el contexto del curso de Programación 1 y Pascal/Free Pascal.
2.  **Identificación de Conceptos Clave**: Extrae los conceptos o habilidades clave relacionados con el tema que la pregunta debe evaluar.
3.  **Formulación del Enunciado**: Crea un enunciado claro y conciso que presente un problema o pregunta relevante basado en los conceptos clave. Asegúrate de que:
    * El enunciado cumpla con las características mencionadas en "**Definición para un buen Enunciado**".
    * Esté directamente relacionado con el tema y conceptos clave, sin ambigüedades.
    * Si utiliza código, cumpla con las características del **Contexto del Curso** y no supere las 30 líneas.
    * Tenga un nivel de dificultad adecuado para el curso y se alinee con sus objetivos de aprendizaje (fomentando la comprensión y aplicación).
    * Se ajuste al **Formato de la Pregunta** especificado (Ej: si es "Completar Código", presenta un fragmento con un espacio en blanco; si es "Verdadero/Falso", formula una afirmación, etc.).
4.  **Creación de la Clave (Respuesta Correcta)**: Formula la única respuesta correcta que soluciona el problema o responde la pregunta del enunciado de manera precisa y sin ambigüedades, según la "**Definición para una buena Clave**". Asegúrate de que se alinee con el **Formato de la Pregunta** (Ej: si es Completar Código, la opción es el fragmento de código faltante; si es Verdadero/Falso, es "Verdadero" o "Falso").
6.  **Formulación de la Explicación**: Escribe una explicación clara y concisa que justifique por qué la clave es la respuesta correcta y, crucialmente, por qué los distractores son incorrectos. Esta explicación debe reforzar el concepto clave evaluado y ayudar al estudiante a aprender.
6.  **Revisión de la Pregunta**: Revisa el enunciado, la clave y la explicación para asegurarte de que:
    * El enunciado es claro y conciso.
    * La clave es la única respuesta correcta.
    * La explicación es precisa y relevante.
    * No hay errores gramaticales o tipográficos.
    * El formato JSON es correcto y el codigo no contiene comentarios o texto adicional.
7.  **Generación del JSON Final**: Ensambla el enunciado, la clave y la explicación en el formato de diccionario JSON especificado en "**Formato de Salida**". Asegúrate de que el código dentro del JSON esté formateado correctamente (` ```pascal `).
