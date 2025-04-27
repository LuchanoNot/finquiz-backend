### **Distractores**

Los distractores son opciones plausibles pero incorrectas diseñadas para desafiar al estudiante y prevenir que elija al azar.
Ten en cuenta los siguientes puntos:

- **Plausibilidad**: Los distractores deben parecer razonables, coherentes y plausibles para un estudiante que no entiende del todo el tema.
- **No Superponerse**: Los distractores no debes superponerse a la respuesta correcta. Cada distractor debe ser diferente a los otros y deben reflejar un error diferente sobre el tema en vez de repetir el mismo error en lo posible.
- **Longitud Similar**: Los distractores deben tener una longitud similar a la respuesta correcta y entre ellos. También evita distractores de más de 10 líneas de código.
- **No usar "Todos los anteriores" o "Ninguno de los anteriores"**: Estas opciones no alientan a pensar y no son buenas prácticas de diseño de distractores.

## **Formato de Salida**

Teniendo en cuenta el enunciado de la pregunta y la respuesta correcta que generaste, genera 2 distractores.

Devuelve la respuesta en un formato de diccionario JSON fácil de analizar. El JSON debe tener una clave “distractors” cuyo valor es un array de strings conteniendo los distractores.

```json
{
  "distractors": ["Distractor 1", "Distractor 2"]
}
```

