### **Distractores**

Los distractores son opciones plausibles pero incorrectas diseñadas para desafiar al estudiante y prevenir que elija al azar.

Teniendo en cuenta el enunciado de la pregunta y la respuesta correcta que generaste previamente, genera 10 distractores.

## **Formato de Salida**

Devuelve la respuesta en un formato de diccionario JSON fácil de analizar. El JSON debe tener una clave “distractors” cuyo valor es un array de JSONs donde cada uno tiene una clave "text" cuyo valor es un string conteniendo el distractor.

Este es el formato de salida que debes generar:

```json
{
  "distractors": [
    {
      "text": "Distractor 1"
    },
    {
      "text": "Distractor 2"
    },
    ...
  ]
}
```
