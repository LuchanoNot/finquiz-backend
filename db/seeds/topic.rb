# frozen_string_literal: true

u1_unit = Unit.find_by(name: 'Componentes básicos')
Topic.find_or_create_by!(
  name: 'Identificadores, constantes y variables',
  short_description: 'En esta sección se introducen los conceptos de identificadores, constantes y variables en Pascal. Se explicará cómo declarar y utilizar estos elementos fundamentales en la programación.',
  description: 'Este tema abarca los conceptos básicos de identificadores, constantes y variables en Pascal. Cómo declarar identificadores válidos, la diferencia entre constantes y variables, y cómo utilizar estos elementos para almacenar y manipular datos en un programa.',
  unit: u1_unit
)
Topic.find_or_create_by!(
  name: 'Instrucciones de asignación y expresiones',
  short_description: 'En esta sección se estudian las instrucciones de asignación y las expresiones en Pascal. Se explicará cómo asignar valores a variables y cómo utilizar expresiones para realizar cálculos.',
  description: 'Este tema abarca las instrucciones de asignación y las expresiones en Pascal. Cómo utilizar la instrucción de asignación para asignar valores a variables, así como cómo construir expresiones para realizar cálculos y manipular datos.',
  unit: u1_unit
)

u2_unit = Unit.find_by(name: 'Condicional, expresiones lógicas y tipos de datos')
Topic.find_or_create_by!(
  name: 'Tipos de datos',
  short_description: 'En esta sección se introducen los tipos de datos básicos en Pascal. Se explicará cómo declarar y utilizar diferentes tipos de datos en un programa.',
  description: 'Este tema abarca los tipos de datos básicos en Pascal, como enteros, reales, booleanos y caracteres. Cómo declarar variables de diferentes tipos de datos y cómo utilizarlas en un programa.',
  unit: u2_unit
)
Topic.find_or_create_by!(
  name: 'Condicionales',
  short_description: 'En esta sección se estudian las estructuras condicionales en Pascal. Se explicará cómo tomar decisiones en un programa utilizando condicionales.',
  description: 'Este tema abarca las estructuras condicionales en Pascal, como if-then-else y case. Cómo utilizar estas estructuras para tomar decisiones en un programa y ejecutar diferentes bloques de código según las condiciones.',
  unit: u2_unit
)
Topic.find_or_create_by!(
  name: 'Expresiones lógicas',
  short_description: 'En esta sección se estudian las expresiones lógicas en Pascal. Se explicará cómo utilizar operadores lógicos para combinar condiciones.',
  description: 'Este tema abarca las expresiones lógicas en Pascal, incluyendo los operadores lógicos como and, or y not. Cómo combinar condiciones utilizando estos operadores para crear expresiones lógicas complejas.',
  unit: u2_unit
)

u3_unit = Unit.find_by(name: 'Secuencia, Selección e Iteraciones')
Topic.find_or_create_by!(
  name: 'Iteraciones',
  short_description: 'En esta sección se estudian las estructuras de iteración en Pascal. Se explicará cómo repetir acciones en un programa utilizando bucles.',
  description: 'Este tema abarca las estructuras de iteración en Pascal, como for, while y repeat. Cómo utilizar estas estructuras para repetir acciones en un programa y controlar el flujo de ejecución.',
  unit: u3_unit
)
Topic.find_or_create_by!(
  name: 'Anidados',
  short_description: 'En esta sección se estudian las estructuras de control anidadas en Pascal. Se explicará cómo combinar diferentes estructuras de control en un programa.',
  description: 'Este tema abarca las estructuras de control anidadas en Pascal, incluyendo la combinación de condicionales e iteraciones. Cómo utilizar estas estructuras para crear programas más complejos y controlar el flujo de ejecución de manera efectiva.',
  unit: u3_unit
)

u4_unit = Unit.find_by(name: 'Arreglos y subrangos')
Topic.find_or_create_by!(
  name: 'Arreglos',
  short_description: 'En esta sección se introducen los arreglos en Pascal. Se explicará cómo declarar y utilizar arreglos para almacenar colecciones de datos.',
  description: 'Este tema abarca los arreglos en Pascal, incluyendo la declaración, inicialización y acceso a elementos de un arreglo. Cómo utilizar arreglos para almacenar y manipular colecciones de datos de manera eficiente.',
  unit: u4_unit
)
Topic.find_or_create_by!(
  name: 'Subrangos',
  short_description: 'En esta sección se introducen los subrangos en Pascal. Se explicará cómo utilizar subrangos para definir rangos de valores válidos para variables.',
  description: 'Este tema abarca los subrangos en Pascal, incluyendo la declaración y uso de subrangos para definir rangos de valores válidos para variables. Cómo utilizar subrangos para mejorar la legibilidad y seguridad del código.',
  unit: u4_unit
)

u5_unit = Unit.find_by(name: 'Registros')
Topic.find_or_create_by!(
  name: 'Registros de variante',
  short_description: 'En esta sección se introducen los registros de variante en Pascal. Se explicará cómo declarar y utilizar registros de variante para almacenar datos de diferentes tipos.',
  description: 'Este tema abarca los registros de variante en Pascal, incluyendo la declaración y uso de registros de variante para almacenar datos de diferentes tipos. Cómo utilizar registros de variante para crear estructuras de datos más flexibles y eficientes.',
  unit: u5_unit
)
Topic.find_or_create_by!(
  name: 'Arreglos con tope',
  short_description: 'En esta sección se introducen los arreglos con tope en Pascal. Se explicará cómo declarar y utilizar arreglos con tope para almacenar colecciones de datos.',
  description: 'Este tema abarca los arreglos con tope en Pascal, incluyendo la declaración y uso de arreglos con tope para almacenar colecciones de datos. Cómo utilizar arreglos con tope para mejorar la eficiencia y seguridad del código.',
  unit: u5_unit
)

u6_unit = Unit.find_by(name: 'Procedimientos, funciones y alcance de variables')
Topic.find_or_create_by!(
  name: 'Procedimientos, funciones y alcance de variables',
  short_description: 'En esta sección se introducen los procedimientos y funciones en Pascal. Se explicará cómo declarar y utilizar procedimientos y funciones para estructurar el código.',
  description: 'Este tema abarca los procedimientos y funciones en Pascal, incluyendo la declaración, inicialización y uso de procedimientos y funciones. Cómo utilizar procedimientos y funciones para estructurar el código y mejorar la legibilidad y reutilización.',
  unit: u6_unit
)

u7_unit = Unit.find_by(name: 'Algoritmos de búsqueda y ordenación')
Topic.find_or_create_by!(
  name: 'Algoritmos de búsqueda y ordenación',
  short_description: 'En esta sección se introducen los algoritmos de búsqueda y ordenación en Pascal. Se explicará cómo implementar algoritmos de búsqueda y ordenación para manipular datos.',
  description: 'Este tema abarca los algoritmos de búsqueda y ordenación en Pascal, incluyendo la implementación de algoritmos de búsqueda lineal y binaria, así como algoritmos de ordenación como burbuja y selección. Cómo utilizar estos algoritmos para manipular datos de manera eficiente y resolver problemas comunes en programación.',
  unit: u7_unit
)

u8_unit = Unit.find_by(name: 'Punteros y listas')
Topic.find_or_create_by!(
  name: 'Punteros',
  short_description: 'En esta sección se introducen los punteros en Pascal. Se explicará cómo declarar y utilizar punteros para manipular datos de forma eficiente.',
  description: 'Este tema abarca los punteros en Pascal, incluyendo la declaración, inicialización y uso de punteros. Cómo utilizar punteros para manipular datos de forma eficiente y resolver problemas comunes en programación.',
  unit: u8_unit
)
Topic.find_or_create_by!(
  name: 'Listas',
  short_description: 'En esta sección se introducen las listas en Pascal. Se explicará cómo declarar y utilizar listas para almacenar colecciones de datos de forma dinámica.',
  description: 'Este tema abarca las listas en Pascal, incluyendo la declaración, inicialización y uso de listas. Cómo utilizar listas para almacenar colecciones de datos de forma dinámica y resolver problemas comunes en programación.',
  unit: u8_unit
)
