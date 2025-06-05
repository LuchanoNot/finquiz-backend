# frozen_string_literal: true

p1_course = Course.find_or_create_by!(name: "Programación 1") do |course|
  course.description = "Curso de Programación 1"
end

Unit.find_or_create_by!(
  name: 'Componentes básicos',
  description: 'En esta unidad se introducen los elementos fundamentales que conforman cualquier programa escrito en Pascal. El objetivo es que el estudiante comprenda la estructura general de un programa, identifique sus partes principales y sea capaz de escribir sus primeros programas simples. Se estudiarán aspectos como la sintaxis básica del lenguaje, el uso de instrucciones simples, y la forma en que se declara y manipula información en memoria.',
  course: p1_course,
  position: 1,
)
Unit.find_or_create_by!(
  name: 'Condicional, expresiones lógicas y tipos de datos',
  description: 'En esta unidad se estudian los tipos de datos básicos en Pascal, así como las expresiones lógicas y las estructuras condicionales. El objetivo es que el estudiante sea capaz de tomar decisiones dentro de un programa, utilizando condicionales simples y compuestos. Se abordarán temas como la comparación de valores, la evaluación de expresiones lógicas y la implementación de estructuras de control como if-then-else.',
  course: p1_course,
  position: 2,
)
Unit.find_or_create_by!(
  name: 'Secuencia, Selección e Iteraciones',
  description: 'En esta unidad se profundiza en la estructura de control de flujo de un programa, abarcando las instrucciones de secuencia, selección e iteración. El objetivo es que el estudiante comprenda cómo se ejecutan las instrucciones en un programa y cómo se pueden utilizar bucles para repetir acciones. Se estudiarán las estructuras de control como for, while y repeat, así como la forma de implementar algoritmos iterativos.',
  course: p1_course,
  position: 3,
)
Unit.find_or_create_by!(
  name: 'Arreglos y subrangos',
  description: 'En esta unidad se introducen los arreglos y subrangos como estructuras de datos fundamentales en Pascal. El objetivo es que el estudiante comprenda cómo almacenar y manipular colecciones de datos utilizando arreglos unidimensionales y multidimensionales. Se abordarán temas como la declaración, inicialización y acceso a elementos de un arreglo, así como la implementación de algoritmos que operan sobre arreglos.',
  course: p1_course,
  position: 4,
)
Unit.find_or_create_by!(
  name: 'Registros',
  description: 'En esta unidad se estudian los registros como una forma de agrupar datos relacionados en Pascal. El objetivo es que el estudiante comprenda cómo definir y utilizar registros para representar estructuras de datos complejas. Se abordarán temas como la declaración de registros, el acceso a sus campos y la implementación de algoritmos que operan sobre registros.',
  course: p1_course,
  position: 5,
)
Unit.find_or_create_by!(
  name: 'Procedimientos, funciones y alcance de variables',
  description: 'En esta unidad se introducen los procedimientos y funciones como herramientas para estructurar y modularizar el código en Pascal. El objetivo es que el estudiante comprenda cómo definir y utilizar procedimientos y funciones, así como el concepto de alcance de variables. Se abordarán temas como la declaración de procedimientos y funciones, la transmisión de parámetros y el uso de variables locales y globales.',
  course: p1_course,
  position: 6,
)
Unit.find_or_create_by!(
  name: 'Algoritmos de búsqueda y ordenación',
  description: 'En esta unidad se estudian los algoritmos de búsqueda y ordenación como herramientas fundamentales para el manejo de datos en programación. El objetivo es que el estudiante comprenda cómo implementar y utilizar ambos tipos de algoritmos. Se abordarán temas como la eficiencia de los mismos y su aplicación en la resolución de problemas.',
  course: p1_course,
  position: 7,
)
Unit.find_or_create_by!(
  name: 'Punteros y listas',
  description: 'En esta unidad se introducen los punteros y listas como estructuras de datos avanzadas en Pascal. El objetivo es que el estudiante comprenda cómo utilizar punteros para manipular datos de forma eficiente y cómo implementar listas como una forma dinámica de almacenar colecciones de datos. Se abordarán temas como la declaración y uso de punteros, así como la implementación de listas enlazadas.',
  course: p1_course,
  position: 8,
)
puts "Units seed executed successfully! :)"
