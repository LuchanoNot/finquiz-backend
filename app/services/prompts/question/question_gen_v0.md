Una **pregunta de múltiple opción** es un formato de evaluación estructurado utilizado para medir el conocimiento, la comprensión y las habilidades de toma de decisiones de un estudiante en un determinado tema, dado un contexto específico sobre lo que se espera que el estudiante sepa.

Una pregunta de múltiple opción consta de tres componentes:

- Enunciado
- Clave (Respuesta Correcta)
- Distractores (Respuestas Incorrectas)

### **Enunciado**

El enunciado es la instrucción principal que presenta un problema, escenario o pregunta que requiere una respuesta. Debe cumplir con las siguientes características:

- **Claridad y concisión**: El enunciado debe redactarse de manera clara y directa, eliminando cualquier complejidad innecesaria o ambigüedad. Evita incluir código que supere las 20 líneas.
- **Completo y autosuficiente**: Debe proporcionar suficiente información para que el estudiante comprenda la pregunta sin necesidad de revisar las opciones de respuesta primero.
- **Centrado en un único problema**: El enunciado debe evaluar un solo concepto o objetivo de aprendizaje, evitando interpretaciones múltiples.
- **Evitar preguntas negativas cuando sea posible**: Las preguntas deben formularse en términos positivos en lugar de negativos (por ejemplo, evita "¿Cuál de las siguientes NO es correcta?"). Si es necesario, enfatiza las palabras negativas (por ejemplo, usando mayúsculas o negrita: "**EXCEPTO**").

### **Clave (Respuesta Correcta)**

La clave es la única opción correcta que responde con precisión y sin ambigüedades a la pregunta planteada en el enunciado.

## **Contexto del Curso**

A continuación, se proporciona una breve descripción del curso **Programación 1**.

El principal objetivo de la unidad curricular *Programación 1* es introducir a los estudiantes a los conceptos básicos de programación utilizando Pascal dentro del paradigma de programación imperativa.

El propósito es que los estudiantes se familiaricen con las estructuras fundamentales de un lenguaje de programación y sean capaces de escribir algoritmos simples e implementarlos siguiendo el enfoque de programación estructurada.

Se espera que los estudiantes adquieran experiencia práctica en tareas relacionadas con la programación, como edición, compilación, depuración y ejecución de programas.

## **Tema de la Pregunta**

<%= question_topics_prompt(topic_id) %>

## **Tipo de Pregunta**

<%= question_type_prompt(topic_id) %>

## **Formato de Salida**

Devuelve la pregunta de múltiple opción en un formato de diccionario JSON fácil de analizar. El JSON debe tener una clave “question” cuyo valor es un string conteniendo el enunciado de la pregunta y otra clave “correctAnswer” cuyo valor es un string conteniendo el texto de la opción correcta

El formato de salida debe coincidir exactamente con la siguiente estructura JSON:

{
  "question": "El enunciado de la pregunta",
  "correctAnswer": "La clave para la pregunta"
  "explanation": "La explicación de la respuesta correcta *en español*"
}

Si alguno de los strings contiene código, formatea el fragmento de código de la siguiente manera:

```pascal
program Hello;
begin
  writeln ('Hello, world.');
end.
```
