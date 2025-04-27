Ahora evalúa los distractores que generaste y agrega un comentario sobre cada uno de ellos.

Piensa esto paso a paso:

1. ¿Son todos ellos plausibles? Los distractores deben parecer razonables, coherentes y plausibles para un estudiante que no entiende del todo el tema.
2. ¿Son todos ellos diferentes? Los distractores no debes superponerse a la respuesta correcta. Cada distractor debe ser diferente a los otros y deben reflejar un error diferente sobre el tema en vez de repetir el mismo error en lo posible.
3. ¿Tienen una longitud similar? Los distractores deben tener una longitud similar a la respuesta correcta y entre ellos. También evita distractores de más de 10 líneas de código.

## **Formato de Salida**

Modifica el JSON de la respuesta anterior para agregar en cada distractor una clave "evaluation" cuyo valor es un string conteniendo el comentario sobre el distractor.

Este es el formato de salida que debes generar:

```json
{
  "distractors": [
    {
      "text": "Distractor 1",
      "evaluation": "Comentario sobre el distractor 1"
    },
    {
      "text": "Distractor 2",
      "evaluation": "Comentario sobre el distractor 2"
    },
    ...
  ]
}
```
