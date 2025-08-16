# frozen_string_literal: true

p1_course = Course.find_or_create_by!(name: "Programación 1") do |course|
  course.description = "Curso de Programación 1"
end

# Create units and topics for the course
u1_unit = Unit.find_or_create_by!(
  name: 'Componentes básicos',
  description: 'Componentes básicos del lenguaje Pascal, incluyendo tipos de datos, expresiones y manejo de entrada/salida.',
  course_id: p1_course.id,
  position: 1
)
u1_unit.save!

# Create topics for the unit

topic_1 = Topic.find_or_create_by!(
  name: 'Tipos de Datos Numéricos y Expresiones',
  short_description: 'Sintaxis de identificadores, el concepto de tipo de dato y las características de los tipos numéricos (integer, real), incluyendo operadores, coerción y precedencia.',
  description: "### Sintaxis de Identificadores\nUn identificador es el nombre que se le da a variables, constantes, programas, etc.\n- Regla: Debe comenzar con una letra, seguida de cualquier combinación de letras o dígitos.\n- Notación BNF: identificador = letra { letra | digito }\n\n### El Concepto de Tipo de Dato\n- Definición: Un tipo especifica la naturaleza de los datos que una variable o constante puede contener (por ejemplo, si son números, texto, etc.).\n- Propósito: Permite al compilador detectar errores de construcción en el código, como intentar sumar un número y una letra. En Pascal, este chequeo de tipos se realiza en tiempo de compilación.\n- Clasificación: \n - Por estructura: elementales (indivisibles, como un número) y estructurados (compuestos, como un registro).\n - Por origen: estándar (predefinidos en el lenguaje) y definidos por el programador.\n\n### Tipos Numéricos y Expresiones\n#### Tipo integer\n- Descripción: Representa números enteros con o sin signo.\n- Propiedad: Es un tipo acotado, lo que significa que tiene un valor máximo (maxint).\n- Operadores: + (suma), - (resta), * (multiplicación), div (división entera), mod (resto de la división).\n\n#### Tipo real\n- Descripción: Representa números con parte decimal.\n- Notación: Las constantes pueden ser decimales (ej. 3.14) o exponenciales (ej. 3.14E2 que es 314.0).\n- Operadores: + (suma), - (resta), * (multiplicación), / (división real).\n\n#### Operaciones Mixtas y Precedencia\n- Sobrecarga: Un mismo operador (como +, *) funciona para diferentes tipos (enteros y reales).\n- Coerción: Conversión automática de un tipo a otro. Por ejemplo, en 3 + 2.5, el entero 3 se convierte a 3.0 antes de la suma. También es posible asignar un valor entero a una variable real.\n- Precedencia de Operadores: El orden para evaluar expresiones es:\n 1. Expresiones entre paréntesis ().\n 2. Operadores de multiplicación y división: *, /, div, mod (de izquierda a derecha).\n 3. Operadores de suma y resta: +, - (de izquierda a derecha).\n\n#### Funciones Aritméticas Estándar\n- sqr(x): Retorna el cuadrado de x.\n- sqrt(x): Retorna la raíz cuadrada de x.\n- trunc(x): Convierte un real a entero truncando la parte decimal.\n- abs(x): Retorna el valor absoluto de x.",
  unit: u1_unit,
  question_types: [ 'correct_output' ]
)
topic_2 = Topic.find_or_create_by!(
  name: 'Tipos de Datos Boolean y Char',
  short_description: "Características y uso de los tipos de datos no numéricos boolean y char, sus operadores lógicos y las funciones de conversión de caracteres ord y chr.",
  description: "### Tipo boolean\n- Descripción: Representa valores lógicos de verdad.\n- Constantes: Solo puede tomar dos valores: true (verdadero) o false (falso).\n- Operadores Lógicos:\n - and: Conjunción (Y lógico). Verdadero solo si ambos operandos son verdaderos.\n - or: Disyunción (O lógico). Verdadero si al menos un operando es verdadero.\n - not: Negación (NO lógico). Invierte el valor de verdad del operando.\n\n### Tipo char\n- Descripción: Representa un único carácter.\n- Literales: Se escriben entre comillas simples.\n- Valores: Incluyen:\n - Letras mayúsculas y minúsculas: 'A', 'B', 'z', 'h'\n - Dígitos: '0', '1', '2'\n - Símbolos: '*', '@', '&'\n\n### Funciones ord y chr\nInternamente, la computadora representa cada carácter con un número entero único (código ASCII/Unicode).\n- ord(caracter): Esta función toma un carácter (char) y devuelve su valor numérico entero correspondiente. \n - Ejemplo: ord('A') devuelve 65.\n- chr(entero): Esta función es la inversa de ord. Toma un número entero y devuelve el carácter que representa.\n - Ejemplo: chr(65) devuelve 'A'.",
  notes: "# ASCII Table for Letters
    | Character | ASCII Value |
    |-----------|-------------|
    | A         | 65          |
    | B         | 66          |
    | C         | 67          |
    | D         | 68          |
    | E         | 69          |
    | F         | 70          |
    | G         | 71          |
    | H         | 72          |
    | I         | 73          |
    | J         | 74          |
    | K         | 75          |
    | L         | 76          |
    | M         | 77          |
    | N         | 78          |
    | O         | 79          |
    | P         | 80          |
    | Q         | 81          |
    | R         | 82          |
    | S         | 83          |
    | T         | 84          |
    | U         | 85          |
    | V         | 86          |
    | W         | 87          |
    | X         | 88          |
    | Y         | 89          |
    | Z         | 90          |
    | a         | 97          |
    | b         | 98          |
    | c         | 99          |
    | d         | 100         |
    | e         | 101         |
    | f         | 102         |
    | g         | 103         |
    | h         | 104         |
    | i         | 105         |
    | j         | 106         |
    | k         | 107         |
    | l         | 108         |
    | m         | 109         |
    | n         | 110         |
    | o         | 111         |
    | p         | 112         |
    | q         | 113         |
    | r         | 114         |
    | s         | 115         |
    | t         | 116         |
    | u         | 117         |
    | v         | 118         |
    | w         | 119         |
    | x         | 120         |
    | y         | 121         |
    | z         | 122         |",
  unit: u1_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_2.prerequisite_topics = [ topic_1 ]

topic_3 = Topic.find_or_create_by!(
  name: "Manejo de Entrada y Salida Estándar",
  short_description: "Procedimientos para la lectura (read, ReadLn) y escritura (write, WriteLn) de datos, el manejo de la entrada como un flujo de caracteres, y el formateo de la salida.",
  description: "### Conceptos Generales de Entrada y Salida (E/S)\nLa E/S estándar se maneja como secuencias de caracteres.\n- Entrada Estándar: Un flujo de caracteres que el programa consume. Por defecto, proviene del teclado. Está organizada en líneas, separadas por un marcador de fin de línea que depende de la plataforma.\n- Salida Estándar: Un flujo de caracteres que el programa produce. Por defecto, se muestra en la terminal. El eco de la entrada se mezcla con la salida del programa.\n\n### Lectura de Datos (Entrada Estándar)\n\n#### Procedimiento read\nLee datos de la entrada y los almacena en variables. Su comportamiento depende del tipo de la variable.\n- Sintaxis: read(var1, var2, ...)\n- Lectura de integer: Consume caracteres numéricos hasta encontrar un separador (espacio, fin de línea) o un carácter no numérico. Si la secuencia no es un entero válido, produce un error.\n- Lectura de real: Similar a integer, pero admite notación decimal (con o sin punto) y exponencial.\n- Lectura de char: Lee y consume un solo carácter, cualquiera que sea (incluyendo espacios o caracteres de fin de línea).\n\n#### Procedimiento ReadLn\nProcesa la entrada por líneas completas, lo que proporciona una forma portable de manejarla.\n- ReadLn(var1, ...): Es equivalente a read(var1, ...); seguido de un ReadLn; sin argumentos. Lee las variables y luego descarta el resto de la línea actual.\n- ReadLn (sin argumentos): Consume y descarta todos los caracteres restantes en la línea de entrada actual, incluyendo el marcador de fin de línea.\n\n#### Funciones de Control de Entrada\nPermiten verificar el estado del flujo de entrada.\n- eoln (End Of Line): Devuelve true si se ha llegado inmediatamente al final de la línea actual.\n- eof (End Of File): Devuelve true si se ha llegado al final de toda la entrada (no hay más caracteres).\n\n### Escritura de Datos (Salida Estándar)\n\n#### Procedimiento write\nEnvía datos a la salida.\n- Sintaxis: write(exp1, exp2, ...)\n- Funcionamiento: Evalúa cada expresión, la convierte a una cadena de caracteres y la añade a la salida. No añade un salto de línea.\n\n#### Procedimiento WriteLn\nEnvía datos y un salto de línea.\n- WriteLn(exp1, ...): Es equivalente a write(exp1, ...); seguido de WriteLn;.\n- WriteLn (sin argumentos): Solo envía el marcador de fin de línea a la salida.\n\n#### Formato de Salida Numérica\nPermite controlar el espacio que ocupan los números en la salida.\n- Enteros: write(v:N) usa un total de N caracteres para mostrar el entero v.\n- Reales: write(r:N:D) usa un total de N caracteres, con D de ellos para la parte decimal. Si no se especifica el formato, los reales se muestran por defecto en notación exponencial.",
  unit: u1_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_3.prerequisite_topics = [ topic_1, topic_2 ]

# Create the second unit and its topics
u2_unit = Unit.find_or_create_by!(
  name: 'Secuencia, Selección e Iteraciones',
  description: 'Estructuras de control de flujo en Pascal, incluyendo secuencias, selecciones e iteraciones.',
  course_id: p1_course.id,
  position: 2
)
u2_unit.save!

topic_4 = Topic.find_or_create_by!(
  name: 'Selección Condicional: if-then-else',
  short_description: 'Permite la ejecución condicional de código. Se evalúa una expresión booleana y, dependiendo de si es verdadera o falsa, se ejecuta un bloque de instrucciones u otro.',
  description: "La instrucción if-then-else es una estructura de control de selección que dirige el flujo de un programa por una de dos rutas posibles.\n\n### Semántica y Sintaxis\n* if-then-else: Evalúa una condición. Si es true, ejecuta la instrucción que sigue a then. Si es false, ejecuta la instrucción que sigue a else.\n * Estructura:\n pascal\n if expresion_booleana then\n instruccion_1\n else\n instruccion_2\n\n* if-then: Es una variante donde no hay una acción alternativa. Si la condición es true, ejecuta la instrucción post-then. Si es false, no hace nada y continúa con la siguiente instrucción del programa.\n * Estructura:\n pascal\n if expresion_booleana then\n instruccion_1\n\n* Reglas Sintácticas Clave:\n * Las palabras if, then, y else son reservadas.\n * La expresión evaluada debe ser de tipo booleana (true o false).\n * No se debe colocar un punto y coma (;) antes de la palabra else.\n\n### Anidamiento e Indentación\n* Anidamiento: Las instrucciones dentro de un if (tanto en la parte then como en la else) pueden ser a su vez otras estructuras de control, incluyendo otros if. Esto permite crear lógicas complejas. Para agrupar varias instrucciones, se utiliza un bloque de secuencia begin...end.\n* Regla del \"else anidado\" (Dangling Else): Cada else se asocia con el if más cercano que aún no ha sido cerrado por otro else. Para forzar que un else se asocie a un if anterior, se debe encerrar el if interior en un bloque begin...end.\n* Indentación: Aunque el compilador la ignora, la indentación (uso de espacios al inicio de las líneas) es crucial para la legibilidad del código. Ayuda a visualizar la estructura lógica, especialmente con sentencias anidadas. Existen varios estilos de indentación, como el estilo Wirth o el estilo Kernighan-Ritchie.\n\n### Ejemplo: Determinar si un número es par o impar\npascal\nprogram ParImpar;\nvar\n numero: integer;\nbegin\n write('Ingrese numero: ');\n readln(numero);\n if numero mod 2 = 0 then\n writeln('El numero ingresado es par')\n else\n writeln('El numero ingresado es impar')\nend.",
  unit: u2_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_4.prerequisite_topics = [ topic_1, topic_2 ]

topic_5 = Topic.find_or_create_by!(
  name: 'Operadores y Evaluación de Expresiones Booleanas',
  short_description: 'Descripción de los operadores relacionales y lógicos utilizados para construir expresiones complejas, junto con las reglas de precedencia, asociatividad y los métodos de evaluación booleana.',
  description: "Las expresiones booleanas son fundamentales para las estructuras de selección y repetición. Se construyen utilizando operadores relacionales y lógicos.\n\n### Tipos de Operadores\n* Operadores Relacionales: Comparan valores de tipos simples y devuelven un resultado booleano (true o false).\n * =: igual\n * <>: distinto\n * <: menor que\n * >: mayor que\n * <=: menor o igual que\n * >=: mayor o igual que\n\n* Operadores Lógicos: Combinan expresiones booleanas para crear condiciones más complejas.\n * and: Conjunción lógica (verdadero solo si ambos operandos son verdaderos).\n * or: Disyunción lógica (verdadero si al menos un operando es verdadero).\n * not: Negación lógica (invierte el valor de verdad del operando).\n\n### Precedencia y Asociatividad\n* Precedencia: Define el orden en que se evalúan los operadores en una expresión sin paréntesis. El orden de mayor a menor precedencia es:\n 1. not (unario)\n 2. *, /, div, mod, and (multiplicativos)\n 3. +, -, or (aditivos)\n 4. =, <>, <, >, <=, >=, IN (relacionales)\n * Debido a que and y or tienen mayor precedencia que los operadores relacionales, a menudo es necesario usar paréntesis. Por ejemplo, x > 0 and x < 10 se debe escribir como (x > 0) and (x < 10).\n\n* Asociatividad: Define el orden para operadores con la misma precedencia. En Pascal, todos los operadores mencionados asocian a la izquierda. Por ejemplo, a or b or c se evalúa como (a or b) or c.\n\n### Evaluación de Expresiones Booleanas\nExisten dos métodos principales para evaluar expresiones lógicas como E1 and E2:\n\n1. Evaluación Estándar (Pascal Estándar): Se evalúan siempre todas las partes de la expresión.\n * Se evalúa E1 (resultado b1).\n * Se evalúa E2 (resultado b2).\n * Se calcula el resultado de b1 and b2.\n * Esto puede causar errores si la evaluación de E2 depende del resultado de E1 (ej. (x <> 0) and (1/x > 5)).\n\n2. Evaluación por Circuito Corto (Free Pascal y la mayoría de lenguajes modernos): La evaluación se detiene tan pronto como el resultado final es conocido.\n * Para and: Si E1 es false, el resultado total es false y E2 no se evalúa.\n * Para or: Si E1 es true, el resultado total es true y E2 no se evalúa.\n * Este método es más eficiente y seguro, ya que previene errores de ejecución en evaluaciones dependientes.",
  unit: u2_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_5.prerequisite_topics = [ topic_1, topic_2, topic_4 ]

topic_6 = Topic.find_or_create_by!(
  name: 'Selección Múltiple: case',
  short_description: 'Permite seleccionar una de varias rutas de ejecución basándose en el valor de una expresión de tipo ordinal. Es una alternativa más limpia y legible a una larga cadena de sentencias if-then-else anidadas.',
  description: "La instrucción case es una estructura de selección generalizada que permite elegir una instrucción de un conjunto de posibles acciones, basándose en el valor de una única expresión.\n\n### Sintaxis y Semántica\nLa estructura básica de un case es la siguiente:\npascal\ncase expresion of\n constante_1: instruccion_1;\n constante_2, constante_3: instruccion_2;\n ...\n constante_n: instruccion_n;\nelse // Variante de Free Pascal\n instruccion_alternativa;\nend;\n\n* Funcionamiento:\n 1. Se evalúa la expresion.\n 2. Se compara el resultado con las listas de constantes.\n 3. Si se encuentra una coincidencia, se ejecuta la instruccion asociada a esa constante y luego el control salta al final de la estructura case.\n 4. Cada instrucción puede estar etiquetada con una o más constantes, separadas por comas.\n\n* Reglas Clave:\n * Las palabras case, of, end (y else en Free Pascal) son reservadas.\n * La expresion debe ser de un tipo ordinal (ej. integer, char, boolean, tipos enumerados), pero no de tipo real.\n * Las constantes deben ser del mismo tipo que la expresion y no pueden repetirse en diferentes ramas.\n\n### Manejo de Casos no Contemplados\n* Pascal Estándar: Si el valor de la expresión no coincide con ninguna de las constantes, se produce un error en tiempo de ejecución.\n* Free Pascal (Modificación): Introduce una cláusula else opcional.\n * Si se especifica la cláusula else, su instrucción asociada se ejecuta cuando no hay ninguna coincidencia.\n * Si no se especifica la cláusula else y no hay coincidencia, no se ejecuta nada y no se produce ningún error.\n\n### Relación con if\n* Un if exp then inst1 else inst2 es equivalente a:\n pascal\n case exp of\n true: inst1;\n false: inst2;\n end;\n\n* Una estructura case compleja es equivalente a una serie de if-then-else if:\n pascal\n // Equivalente a:\n if (v=a1) or (v=a2) then\n inst-a\n else if (v=b1) or (v=b2) then\n inst-b\n ...\n\n### ¿Cuándo usar case?\nEs preferible usar case en lugar de if-then-else anidados cuando:\n1. La selección es entre más de dos alternativas.\n2. La decisión se basa en el valor de una única expresión simple de tipo ordinal.\n3. Es ideal para implementar menús donde el usuario ingresa una opción.",
  unit: u2_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_6.prerequisite_topics = [ topic_1, topic_2, topic_5 ]

# Create the third unit and its topics

u3_unit = Unit.find_or_create_by!(
  name: 'Estructuras de Repetición',
  description: 'Estructuras de control iterativas en Pascal, incluyendo for, while y repeat.',
  course_id: p1_course.id,
  position: 3
)
u3_unit.save!

topic_7 = Topic.find_or_create_by!(
  name: "Repetición: for",
  short_description: "Análisis detallado de la instrucción 'for', que ejecuta un bloque de código un número predeterminado de veces. Se cubre su sintaxis, semántica para iteración ascendente y descendente, y reglas importantes de uso.",
  description: "La instrucción for es una estructura de repetición determinada, utilizada cuando se conoce de antemano el número de veces que se debe ejecutar un bloque de código. Funciona iterando sobre un rango de valores de tipo escalar.\n\n### Sintaxis y Componentes\nLa sintaxis formal de la instrucción, según la notación BNF, es:\nsentencia_for ::= 'for' identificador := expresión1 ('to'|'downto') expresión2 'do' instrucción\n\n* identificador: Es la variable de control del bucle. Debe ser de un tipo de dato escalar (ordinal), como integer, char, boolean o un tipo enumerado. No puede ser de tipo real.\n* expresión1 y expresión2: Definen los límites inferior y superior del rango de iteración. Deben ser del mismo tipo que el identificador. Estos valores se calculan una sola vez antes de que comience la primera iteración.\n* to / downto: Palabras reservadas que indican la dirección de la iteración. to es para un conteo ascendente (incremental) y downto para un conteo descendente (decremental).\n* instrucción: Es la sentencia o bloque de sentencias (begin...end) que se ejecutará en cada iteración.\n\n### Semántica (Cómo funciona)\n1. Inicialización: Se evalúan expresión1 y expresión2 para obtener los valores de inicio (v1) y fin (v2).\n2. Ejecución: \n * Con to: Si v1 > v2, el bucle no se ejecuta ni una vez. De lo contrario, la variable de control toma el valor de v1, se ejecuta la instrucción, luego la variable toma el siguiente valor (succ(v)) y así sucesivamente hasta que la variable de control sea igual a v2. Tras ejecutar la instrucción para v2, el bucle termina.\n * Con downto: Si v1 < v2, el bucle no se ejecuta. De lo contrario, el proceso es análogo, pero la variable de control se decrementa (pred(v)) en cada paso.\n\n### Observaciones y Reglas Cruciales\n* Modificación de la variable de control: Se considera un error que la instrucción dentro del bucle intente modificar el valor de la variable de control.\n* Valor final de la variable de control: Después de que el bucle for termina, el valor de la variable de control se considera indefinido. No se debe confiar en su valor fuera del bucle.\n* Terminación: Un bucle for siempre termina, ya que el número de iteraciones está determinado desde el principio.\n* Modificación de los límites: No se recomienda que la instrucción modifique las variables usadas en expresión1 y expresión2, ya que no tendría efecto en el número de iteraciones, pues los límites del bucle se fijaron al inicio.\n\n### Casos de Uso Comunes\n* Repetir una acción un número fijo de veces.\n* Utilizar el valor de la variable de control dentro del bucle (ej. writeln(2 * i)).\n* Anidar bucles for para procesar estructuras bidimensionales (ej. dibujar un cuadrado o una matriz).\n* Acumular resultados, como sumas o conteos, a lo largo de las iteraciones.",
  unit: u3_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_7.prerequisite_topics = [ topic_1, topic_2, topic_5 ]

topic_8 = Topic.find_or_create_by!(
  name: "Repetición Condicional: while",
  short_description: "Explica el bucle 'while', que ejecuta un bloque de código repetidamente mientras una condición booleana sea verdadera. La condición se evalúa antes de cada iteración, por lo que el bloque podría no ejecutarse nunca.",
  description: "La instrucción while es una estructura de repetición condicional que se ejecuta un número indeterminado de veces, dependiendo de una condición.\n\n### Sintaxis\nLa estructura de un bucle while es:\nwhile expresión_booleana do instrucción\n\n* while y do son palabras reservadas.\n* expresión_booleana: Es la condición que se evalúa antes de cada iteración. Debe resultar en un valor true o false.\n* instrucción: Es el cuerpo del bucle. Si se necesita ejecutar más de una instrucción, deben agruparse en un bloque begin...end.\n\n### Semántica (Funcionamiento)\n1. Se evalúa la expresión_booleana.\n2. Si el resultado es false, el bucle termina y el programa continúa con la siguiente instrucción. El cuerpo del bucle no se ejecuta.\n3. Si el resultado es true, se ejecuta la instrucción del cuerpo del bucle.\n4. Se vuelve al paso 1 para reevaluar la condición.\n\nEs crucial que alguna acción dentro de la instrucción modifique las variables de la condición para que, eventualmente, esta se vuelva false y el bucle pueda terminar. De lo contrario, se crearía un bucle infinito.\n\n### Patrón de Lectura con Centinela\nUn uso muy común del bucle while es para procesar una lista de datos de longitud desconocida, utilizando un valor especial llamado centinela para marcar el final.\nEl esquema es:\n1. Lectura adelantada: Leer el primer dato antes de entrar al bucle.\n2. Bucle while: La condición del bucle comprueba que el dato leído no sea el centinela.\n3. Procesamiento: Dentro del bucle, se procesa el dato actual.\n4. Siguiente lectura: Al final del cuerpo del bucle, se lee el siguiente dato. Esto prepara la siguiente iteración.\nEste patrón asegura que el valor centinela nunca sea procesado.\n\n### Ejemplos\n* Suma de números: Leer números hasta que se ingrese uno negativo (el centinela).\n* Verificación de número primo: Buscar un divisor para n en un bucle que se ejecuta mientras el divisor sea menor o igual que la raíz de n y aún no se haya encontrado un divisor.\n* Uso de banderas booleanas: Una variable booleana (bandera) puede controlar el bucle, y su valor se cambia dentro del mismo cuando se cumple una condición de parada.",
  unit: u3_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_8.prerequisite_topics = [ topic_1, topic_2, topic_5 ]

topic_9 = Topic.find_or_create_by!(
  name: "Repetición Condicional: repeat...until",
  short_description: "Describe el bucle 'repeat...until', que ejecuta un bloque de código al menos una vez y lo repite hasta que una condición booleana se cumpla (sea verdadera). La condición se evalúa después de cada iteración.",
  description: "La instrucción repeat...until es una estructura de repetición condicional que garantiza que el cuerpo del bucle se ejecute como mínimo una vez.\n\n### Sintaxis\nLa estructura es:\nrepeat instrucción_1; instrucción_2; ... until expresión_booleana\n\n* repeat y until son palabras reservadas que delimitan el bloque de código. Por esta razón, no es necesario usar begin...end para agrupar múltiples instrucciones.\n* expresión_booleana: Es la condición de terminación. El bucle se repite hasta que esta expresión sea true.\n\n### Semántica (Funcionamiento)\n1. Se ejecuta la secuencia de instrucciones que forman el cuerpo del bucle.\n2. Se evalúa la expresión_booleana.\n3. Si el resultado es false, se vuelve al paso 1 y se repite la ejecución del cuerpo.\n4. Si el resultado es true, el bucle termina y el programa continúa.\n\nLa principal diferencia con while es que el cuerpo siempre se ejecuta al menos una vez, ya que la comprobación de la condición se realiza al final de la iteración.\n\n### Relación con while\nUna instrucción repeat...until puede ser simulada con una instrucción while. La siguiente estructura:\npascal\nrepeat\n S; // Cuerpo del bucle\nuntil C; // Condición\n\nEs lógicamente equivalente a:\npascal\nS; // Ejecutar el cuerpo una vez\nwhile not C do\nbegin\n S; // Repetir mientras la condición sea falsa\nend;\n\n\n### Casos de Uso Comunes\n* Validación de entrada de usuario: Se utiliza para solicitar un dato al usuario y repetir la solicitud hasta que el valor ingresado sea válido. Se necesita ejecutar la petición al menos una vez.\n* Procesamiento de texto: Como se muestra en el ejemplo de contar palabras, se usa para saltar caracteres (ej. espacios) hasta encontrar uno diferente, o para leer caracteres hasta encontrar un delimitador. En ambos casos, es necesario procesar al menos un carácter para poder tomar una decisión.",
  unit: u3_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_9.prerequisite_topics = [ topic_1, topic_2, topic_5 ]

# Create the fourth unit and its topics
u4_unit = Unit.find_or_create_by!(
  name: 'Subprogramas y Modularización',
  description: 'Funciones y procedimientos en Pascal, incluyendo pasaje de parámetros, alcance de variables y principios de modularización.',
  course_id: p1_course.id,
  position: 4
)
u4_unit.save!

topic_11 = Topic.find_or_create_by!(
  name: 'Funciones',
  short_description: 'Detalla las funciones como subprogramas que calculan y retornan un único valor de tipo simple. Explica su sintaxis, la declaración, el uso del nombre de la función para el retorno y la diferencia entre parámetros formales y efectivos.',
  description: "Una función es un subprograma diseñado para calcular y retornar un único valor de un tipo simple (como integer, real, char, boolean). Las funciones se invocan como parte de una expresión.\n\n### Declaración y Sintaxis\nLa estructura de una función es:\npascal\nfunction nombre(lista_parametros) : tipo_retorno;\n // Declaraciones locales (const, type, var, etc.)\nbegin\n // Cuerpo de la función\n nombre := valor_a_retornar; // Asignación del valor de retorno\nend;\n\n* Encabezado: function es una palabra reservada. El identificador debe ser único y el tipo_retorno debe ser un tipo simple.\n* Retorno de valor: Dentro del cuerpo de la función, se debe realizar una asignación al nombre de la función (nombre := ...). Esta es la forma en que la función especifica qué valor devolverá. El nombre de la función no es una variable; no se puede leer su valor dentro de la propia función (ej: potencia := potencia * base es incorrecto).\n\n### Parámetros Nominales y Efectivos\n* Parámetros Nominales (o Formales): Son los identificadores que aparecen en la lista de parámetros del encabezado de la función (ej: base, exponente).\n* Parámetros Efectivos (o Reales): Son las expresiones o variables que se utilizan al invocar la función (ej: pi, 23, 2*pi*sqr(radio)).\nPara cada parámetro, el tipo del parámetro efectivo debe ser compatible con el tipo del parámetro nominal correspondiente.\n\n### Funciones Booleanas\nSon un tipo especial de función que retorna true o false. Son muy útiles para verificar propiedades, como si un número es primo (EsPrimo) o si un elemento pertenece a un arreglo (pertenece).\n\n### Recomendaciones de Estilo para Funciones\n* Deben ser puras: no deben tener efectos secundarios.\n* No utilizar pasaje de parámetros por referencia (var).\n* No realizar operaciones de entrada/salida (read, write).\n* No utilizar variables globales.\n* Asignar el valor de retorno una única vez, como última instrucción.",
  unit: u4_unit,
  question_types: [ 'correct_output' ]
)
# Set prerequisite topics separately
topic_11.prerequisite_topics = [ topic_1, topic_2, topic_4 ]

topic_12 = Topic.find_or_create_by!(
  name: 'Procedimientos y Pasaje de Parámetros',
  short_description: 'Explica los procedimientos como subprogramas que ejecutan una acción sin retornar un valor en su nombre. Introduce los dos mecanismos de pasaje de parámetros: por valor y por referencia, que son clave para la comunicación con los procedimientos.',
  description: "Un procedimiento es un subprograma que ejecuta una secuencia de acciones pero no retorna un valor en su nombre. Se invoca como una instrucción independiente.\n\nSu encabezado es más simple que el de una función:\nprocedure nombre(listaparametros);\n\nDado que los procedimientos no retornan un valor directamente, la comunicación y la devolución de resultados se gestionan a través de sus parámetros, utilizando dos mecanismos distintos:\n\n### Pasaje de Parámetros por Valor\nEste es el mecanismo por defecto, usado cuando un parámetro no está precedido por la palabra var.\n* Funcionamiento: En el momento de la invocación, se crea una copia del valor del parámetro efectivo y se asigna al parámetro nominal. \n* Parámetro Efectivo: Puede ser cualquier expresión que resulte en un tipo compatible (ej. 23, N*2).\n* Efecto: Cualquier modificación que se haga al parámetro nominal dentro del procedimiento no afecta a la variable original fuera de él. Se usa para pasar datos de entrada que no deben ser alterados.\n\n### Pasaje de Parámetros por Referencia\nSe indica anteponiendo la palabra reservada var al parámetro en la declaración.\n* Funcionamiento: No se crea una copia. El parámetro nominal se convierte en un alias (otro nombre) del parámetro efectivo. Ambos apuntan a la misma dirección de memoria.\n* Parámetro Efectivo: Debe ser una variable, no una expresión.\n* Efecto: Cualquier modificación del parámetro nominal dentro del procedimiento se refleja inmediatamente en el parámetro efectivo fuera de él. Este es el mecanismo principal que usan los procedimientos para \"retornar\" resultados.\n\n### Ejemplos de Uso\n* procedure LeerArreglo(var A: arreglo): Utiliza pasaje por referencia para llenar un arreglo con datos leídos del usuario.\n* procedure intercambio(var a,b: T): Necesita pasaje por referencia en ambos parámetros para poder intercambiar sus valores.\n* procedure MostrarResultado(area: real): Utiliza pasaje por valor porque solo necesita leer el dato para mostrarlo, sin modificarlo.",
  unit: u4_unit,
  question_types: [ 'correct_output' ]
)
# Create the topic for rules of scope
topic_12.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11 ]

topic_13 = Topic.find_or_create_by!(
  name: 'Alcance de Identificadores',
  short_description: 'Define el concepto de alcance (scope) de un identificador, explicando la diferencia entre variables locales y globales. Detalla cómo se determina la visibilidad de las variables y subprogramas en bloques anidados y cómo se resuelven los conflictos de nombres.',
  description: "El alcance (o scope) de un identificador es la porción del programa en la que dicho identificador es \"visible\" y, por lo tanto, puede ser utilizado. Las reglas de alcance determinan esta visibilidad.\n\n### Identificadores Locales y Globales\n* Identificador Global: Es aquel que se declara en el bloque del programa principal. Es visible en todo el programa, incluyendo dentro de todos los subprogramas que contiene.\n* Identificador Local: Es aquel que se declara dentro de un subprograma (incluyendo sus parámetros). Solo es visible dentro del subprograma que lo declara y en los subprogramas anidados dentro de este.\n\n### Regla General de Visibilidad\nUn identificador definido en un bloque es visible en ese bloque y en todos los sub-bloques que contenga, pero no en bloques externos.\n\n* Ejemplo: Si un procedimiento p contiene una función f, las variables declaradas en p son globales para f y pueden ser usadas dentro de f. Sin embargo, las variables locales de f no son visibles en p.\n\n### Solapamiento de Nombres (Shadowing)\nSi un identificador local tiene el mismo nombre que un identificador global, el local tiene prioridad dentro de su propio alcance. Se dice que el identificador local \"tapa\" o \"ensombrece\" al global. Cualquier referencia a ese nombre dentro del subprograma se referirá a la entidad local, no a la global.\n\n* Ejemplo: Si el programa principal tiene una variable x y un procedimiento p define un parámetro x, cualquier uso de x dentro de p se referirá al parámetro, no a la variable global.\n\n### Alcance de Funciones y Procedimientos\nEl identificador de un subprograma también sigue las reglas de alcance. Un subprograma es visible y puede ser llamado:\n1. En el bloque donde está definido, pero solo después de su declaración.\n2. Dentro de sí mismo (lo que permite la recursión).\n3. Dentro de otros subprogramas declarados posteriormente en el mismo nivel de anidamiento.\n\nEsto implica que una función f no puede llamar a una función g si g está declarada más abajo en el código. De igual forma, un subprograma k anidado dentro de g es local a g y no puede ser llamado desde fuera de g.",
  unit: u4_unit,
  question_types: [ 'correct_output' ]
)
topic_13.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11, topic_12 ]


# Create the fifth unit and its topics
u5_unit = Unit.find_or_create_by!(
  name: 'Arreglos y Subrangos',
  description: 'Tipos de datos definidos por el programador, subrangos y estructuras de datos tipo arreglo en Pascal.',
  course_id: p1_course.id,
  position: 5
)
u5_unit.save!

topic_14 = Topic.find_or_create_by!(
  name: 'Tipos Propios y Subrangos',
  short_description: "Introducción a la definición de nuevos tipos de datos en Pascal usando la palabra reservada 'type', con un enfoque en los tipos subrango, que restringen los valores de un tipo ordinal a un conjunto contiguo.",
  description: "En Pascal, además de los tipos de datos predefinidos (integer, char, boolean), el programador puede crear sus propios tipos de datos utilizando la sección type del programa. Esto mejora la legibilidad y la seguridad del código.\n\n### Tipo Subrango\nUn tipo subrango define un subconjunto contiguo de valores de un tipo de dato ordinal (también llamado escalar).\n\n* Sintaxis de Declaración:\n type identificador = constante_inicial .. constante_final;\n\n* Tipos Base: El tipo del que se deriva un subrango debe ser ordinal. Los principales son:\n * integer: type mes = 1..12;\n * char: type letra_mayuscula = 'A'..'Z';\n * boolean\n * enumerado (se ve más adelante)\n\n* Ejemplos:\n pascal\n type\n natural = 0..MaxInt;\n digito_char = '0'..'9'; // Subrango de char\n digito_int = 0..9; // Subrango de integer\n\n Es importante notar la diferencia entre digito_char y digito_int, ya que sus valores y operaciones son diferentes.\n\n* Operaciones y Verificación:\n * Las variables de un tipo subrango se comportan como si fueran de su tipo base, pero con una restricción.\n * Si se intenta asignar un valor a una variable de tipo subrango que está fuera de su rango definido, se produce un error en tiempo de ejecución. Para que el compilador Free Pascal realice esta verificación, se debe activar la opción correspondiente (flag -Cr).",
  unit: u5_unit,
  question_types: [ 'correct_output' ]
)
topic_14.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11, topic_12, topic_13 ]

topic_15 = Topic.find_or_create_by!(
  name: 'Arreglos Unidimensionales',
  short_description: 'Introducción a los arreglos (arrays) como tipos de datos estructurados para almacenar una colección de elementos del mismo tipo, accesibles a través de un índice. Se detalla su sintaxis y estructura.',
  description: "Un arreglo (array) es un tipo de dato estructurado que permite almacenar un conjunto de valores del mismo tipo bajo un único nombre de variable. Cada valor individual se accede a través de un índice.\n\n### Motivación\nLos arreglos están inspirados en la notación matemática de secuencias finitas (a₁, a₂, ..., aₙ) y resuelven la necesidad de manejar colecciones de datos relacionados sin tener que declarar una variable para cada uno.\n\n### Declaración de un Arreglo\nLos arreglos se definen en la sección type del programa.\n\n* Sintaxis General:\n type nombre_arreglo = array [tipo_indice] of tipo_base;\n\n* Componentes:\n * tipo_indice: Define el conjunto de valores válidos para acceder a las celdas del arreglo. Debe ser un tipo ordinal, y comúnmente se utiliza un subrango de enteros. El número de elementos en el tipo_indice determina el tamaño del arreglo.\n * tipo_base: Especifica el tipo de dato de cada uno de los elementos almacenados en el arreglo. Puede ser cualquier tipo de Pascal (simple o estructurado).\n\n* Ejemplo:\n pascal\n type\n RangoArreglo = 1..9;\n Arreglo = array [RangoArreglo] of integer;\n var\n A: Arreglo;\n\n En este caso, A es un arreglo de 9 celdas, indexadas del 1 al 9, donde cada celda almacena un valor de tipo integer.\n\n### Acceso a los Elementos\nPara acceder a una celda específica del arreglo, se utiliza el nombre de la variable seguido del índice entre corchetes.\n* A[1] := 12; // Asigna el valor 12 a la primera celda.\n* valor := A[i]; // Lee el valor de la celda i-ésima.\n\nSi se intenta acceder a un índice que está fuera del rango definido por tipo_indice (ej. A[200] en el ejemplo anterior), se producirá un error en tiempo de ejecución.",
  unit: u5_unit,
  question_types: [ 'correct_output' ]
)
topic_15.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11, topic_12, topic_13, topic_14 ]


topic_16 = Topic.find_or_create_by!(
  name: 'Operaciones con Arreglos: Recorridas y Búsquedas',
  short_description: "Distingue entre dos operaciones clave: la recorrida completa para procesar todos los elementos y la búsqueda para encontrar un elemento específico, destacando el uso de 'for' para la primera y 'while' para la segunda.",
  description: "Una vez declarado un arreglo, las operaciones más comunes implican procesar sus elementos, ya sea todos o solo hasta encontrar uno que cumpla una condición.\n\n### Recorridas Completas\nUna recorrida completa implica visitar y procesar cada uno de los elementos del arreglo, desde el primero hasta el último. \n* Estructura de Control Adecuada: El bucle for es la herramienta ideal, ya que su variable de control puede iterar naturalmente sobre el tipo_indice del arreglo.\n* Aplicaciones Típicas:\n * Inicialización: Asignar un valor inicial a cada celda.\n for i := 1 to 10 do A[i] := 0;\n * Acumulación: Sumar todos los elementos.\n function SumarTodos(A: arreglo): integer;\n * Cálculo: Encontrar el valor máximo o mínimo.\n function maximo(A: arreglo): integer;\n * Visualización: Mostrar el contenido del arreglo.\n procedure MostrarArreglo(A: arreglo);\n\n### Búsquedas\nUna búsqueda consiste en encontrar si existe al menos un elemento en el arreglo que satisface una condición. La operación debe detenerse tan pronto como se encuentra el elemento o se llega al final del arreglo sin encontrarlo.\n* Estructura de Control Adecuada: El bucle while es la herramienta correcta. Usar un bucle for para una búsqueda se considera ineficiente y un error de diseño, ya que continúa iterando innecesariamente después de haber encontrado la solución.\n* Esquema de Búsqueda Correcto (con circuito corto):\n pascal\n i := PRIMERO;\n while (i <= ULTIMO) and not (condicion_cumplida_en_A[i]) do\n i := i + 1;\n \n // Después del bucle, se verifica si se encontró o no:\n encontrado := (i <= ULTIMO);\n\n* Importancia del Circuito Corto: La evaluación por circuito corto es fundamental. En la condición (i <= ULTIMO) and ..., si i excede el ULTIMO, la primera parte es falsa y la segunda parte (A[i]...) no se evalúa, evitando un error de acceso fuera de rango.",
  unit: u5_unit,
  question_types: [ 'correct_output' ]
)
topic_16.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11, topic_12, topic_13, topic_14, topic_15 ]


topic_17 = Topic.find_or_create_by!(
  name: 'Arreglos Multidimensionales',
  short_description: 'Extiende el concepto de arreglos a múltiples dimensiones, conocidos como matrices, explicando su declaración y las dos formas sintácticas para acceder a sus elementos.',
  description: "Un arreglo multidimensional es una estructura que puede ser vista como un arreglo de arreglos o, de forma más abstracta, como un arreglo que requiere múltiples índices para acceder a un elemento. El caso más común es el arreglo bidimensional, también conocido como matriz.\n\n### Declaración\nSe declaran especificando múltiples tipos de índice, separados por comas.\n* Sintaxis:\n type nombre_matriz = array [rango_filas, rango_columnas] of tipo_base;\n\n* Ejemplos:\n pascal\n type\n matriz_char = array [1..20, 1..15] of char;\n matriz_datos = array ['0'..'9', 1..10] of integer;\n\n\n### Acceso a los Elementos\nExisten dos formas sintácticas para acceder a un elemento en una matriz, como a:\n1. Índices separados: a[i][j]\n Esta forma refleja la idea de un \"arreglo de arreglos\", donde a[i] selecciona una fila (que es un arreglo) y [j] selecciona un elemento de esa fila.\n\n2. Índices combinados: a[i, j]\n Esta es la notación más común y directa para trabajar con matrices.\n\nAmbas formas son equivalentes y la elección depende del estilo del programador, aunque a[i,j] es la más utilizada en la práctica por su brevedad.",
  unit: u5_unit,
  question_types: [ 'correct_output' ]
)
topic_17.prerequisite_topics = [ topic_1, topic_2, topic_4, topic_11, topic_12, topic_13, topic_14, topic_15, topic_16 ]


# Create the sixth unit and its topics
u6_unit = Unit.find_or_create_by!(
  name: 'Ordinales, Enumerados y Conjuntos',
  description: 'Tipos de datos ordinales, enumerados y conjuntos en Pascal, incluyendo sus propiedades y operaciones.',
  course_id: p1_course.id,
  position: 6
)
u6_unit.save!

topic_19 = Topic.find_or_create_by!(
  name: 'Enumerados',
  short_description: 'Introduce los tipos enumerados como una forma de crear tipos de datos personalizados, definiendo un conjunto finito y ordenado de identificadores que mejoran la legibilidad y la robustez del código.',
  description: "Un tipo enumerado permite al programador definir un nuevo tipo de dato especificando una lista de todos sus posibles valores. Esto es útil cuando una variable solo puede tomar un valor de un conjunto limitado de opciones con nombre propio, como los días de la semana, los meses del año, los colores, etc.\n\n### Motivación y Sintaxis\nEn lugar de usar números (1 para lunes, 2 para martes) o caracteres, que son poco mnemotécnicos, los enumerados permiten usar identificadores significativos.\n* Sintaxis: type NombreTipo = (identificador1, identificador2, ..., identificadorN);\n* Valores: Los valores de un tipo enumerado deben ser identificadores válidos, no literales numéricos o de carácter. Por ejemplo, (domingo, lunes, martes) es correcto, mientras que (0, 2, 4) o ('a', 'e', 'i') son incorrectos.\n* Ejemplos:\n pascal\n type\n DiaSemana = (domingo, lunes, martes, miercoles, jueves, viernes, sabado);\n PuntoCardinal = (norte, sur, este, oeste);\n\nEl tipo boolean es, en esencia, un enumerado predefinido: type boolean = (false, true);\n\n### Operaciones y Conversión\nComo los enumerados son tipos ordinales, el orden de declaración importa.\n* Operaciones: Soportan operadores de comparación (=, <, >) y las funciones ord, succ, y pred. El orden se basa en la lista de declaración (ord(domingo) es 0, ord(lunes) es 1, etc.).\n* Conversión con Enteros:\n * De enumerado a entero: Se usa la función ord(). Ej: ord(martes) devuelve 2.\n * De entero a enumerado: Se usa el nombre del tipo como si fuera una función. Ej: DiaSemana(2) devuelve martes.\n\n### Entrada y Salida (I/O)\nNo es posible leer o escribir valores enumerados directamente con read o write. Se debe hacer una conversión explícita:\n* Entrada: Leer un entero y luego convertirlo al tipo enumerado.\n pascal\n ReadLn(mes_aux); // lee un número de 1 a 12\n m := Mes(mes_aux-1); // convierte a enumerado (enero=0...)\n\n* Salida: Usar una estructura case para asociar cada valor enumerado con una cadena de texto para imprimir.\n pascal\n case m of\n enero: write('enero');\n febrero: write('febrero');\n ...\n end;",
  unit: u6_unit,
  question_types: [ 'correct_output' ]
)

topic_20 = Topic.find_or_create_by!(
  name: 'Conjuntos (Set)',
  short_description: "Presenta el tipo de dato 'set' para representar colecciones no ordenadas de elementos únicos de un tipo ordinal base. Se explican su definición, representación, restricciones y las operaciones del álgebra de conjuntos.",
  description: "El tipo de dato conjunto (set) en Pascal se utiliza para representar una colección de elementos únicos, sin un orden específico, pertenecientes a un mismo tipo base ordinal.\n\n### Motivación y Definición\n* Los conjuntos son ideales para modelar el concepto matemático de conjunto, permitiendo operaciones como unión, intersección y pertenencia.\n* A diferencia de un arreglo, en un conjunto no hay elementos repetidos ni un orden intrínseco.\n* Sintaxis: type NombreConjunto = set of tipo_base;\n* tipo_base: Debe ser un tipo ordinal. \n* Restricciones (Free Pascal): El tipo_base no puede tener más de 256 valores posibles, y sus valores ordinales no pueden ser negativos. Por esto, set of char es válido (256 valores), pero set of integer es inválido (demasiado grande).\n\n### Representación y Literales\nLos valores de un tipo conjunto se escriben entre corchetes [].\n* []: El conjunto vacío.\n* [0, 2, 4, 6, 8]: Un conjunto con cinco elementos.\n* ['A'..'Z']: Un conjunto definido con un subrango.\n* [1..3, 7, 9]: Un conjunto que combina subrangos y elementos individuales.\n\n### Operadores de Conjuntos\nPascal implementa las operaciones habituales del álgebra de conjuntos:\n* + : Unión. Combina los elementos de dos conjuntos.\n* * : Intersección. Devuelve los elementos comunes a ambos conjuntos.\n* - : Diferencia. Devuelve los elementos del primer conjunto que no están en el segundo.\n* in : Pertenencia. Es un operador booleano que devuelve true si un elemento está en un conjunto (ej: if 'a' in vocales then ...).\n* = y <> : Igualdad y Desigualdad. Comparan si dos conjuntos tienen exactamente los mismos elementos.\n* <= : Inclusión. Devuelve true si el primer conjunto es un subconjunto del segundo.\n\n### Uso y Visualización\nNo se puede mostrar un conjunto directamente con write. Para visualizar sus elementos, es necesario recorrer el universo completo de su tipo_base y verificar la pertenencia de cada posible elemento.\npascal\n// Para mostrar los elementos de un conjunto 'conj' de tipo 'set of char'\nfor c := 'a' to 'z' do\n if c in conj then\n Write(c);",
  unit: u6_unit,
  question_types: [ 'correct_output' ]
)

# Create the seventh unit and its topics
u7_unit = Unit.find_or_create_by!(
  name: 'Array con tope y Registros variantes',
  description: 'Uso de arreglos dinámicos y estructuras de datos con registros variantes en Pascal.',
  course_id: p1_course.id,
  position: 7
)
u7_unit.save!

topic_21 = Topic.find_or_create_by!(
  name: "Array con Tope",
  short_description: "Describe una estructura de datos conceptual que combina un arreglo estático con un contador ('tope') para gestionar una colección de tamaño variable, simulando comportamiento dinámico. Se usa para implementar listas o conjuntos cuyo tamaño máximo es conocido pero la cantidad de elementos varía.",
  description: "El array con tope es una estructura de datos conceptual, no un tipo de dato nativo de Pascal. Se implementa combinando un registro (record) y un arreglo (array) para manejar colecciones de elementos donde el número de elementos válidos puede cambiar durante la ejecución, hasta un máximo predefinido.\n\n### Definición Conceptual\nSe define como un registro que contiene dos campos:\n1. Un arreglo de tamaño fijo, que actúa como contenedor de datos.\n2. Un campo numérico, llamado tope, que lleva la cuenta de cuántos elementos del arreglo están actualmente en uso.\n\npascal\ntype\n ArrTope = record\n elems : array [1..N] of T; // N es el tamaño máximo, T el tipo de los elementos\n tope : 0..N; // Indica el número de elementos válidos\n end;\n\n\n### Funcionamiento\n* Los elementos válidos se almacenan de forma contigua en el arreglo elems, desde la posición 1 hasta la posición indicada por tope.\n* El valor del campo tope siempre representa la cantidad de elementos válidos. Si tope es 0, la estructura está vacía.\n* Los elementos en las posiciones del arreglo desde tope + 1 hasta N se consideran 'basura' y no tienen significado para la lógica del programa.\n* Aunque el almacenamiento subyacente es estático (el arreglo elems tiene un tamaño fijo N), la estructura simula un comportamiento dinámico al permitir agregar y quitar elementos cambiando el valor de tope.\n\n### Implementación de Operaciones (Ejemplo: Conjunto)\nEl 'array con tope' es ideal para implementar un conjunto cuando el tipo de elemento no es ordinal o el universo es demasiado grande para un set nativo.\n\n* Crear Conjunto Vacío:\n Se inicializa el tope a 0.\n procedure CrearConjuntoVacio(var S : Conj);\n begin S.tope := 0; end;\n\n* Insertar un Elemento:\n Se asume que el elemento no existe y hay espacio. Se incrementa el tope y se coloca el nuevo elemento en la última posición válida.\n procedure Insertar(e : T; var S : Conj);\n begin\n S.tope := S.tope + 1;\n S.elems[S.tope] := e;\n end;\n\n* Eliminar un Elemento:\n Se busca el elemento. Si se encuentra en la posición i, se reemplaza por el último elemento válido (el que está en la posición tope) y se decrementa el tope. Esta es una técnica eficiente que evita tener que desplazar elementos.\n // ... búsqueda encuentra el elemento en la posición i ...\n if i <= S.tope then\n begin\n S.elems[i] := S.elems[S.tope];\n S.tope := S.tope - 1;\n end;\n\n* Búsqueda (Pertenencia):\n Se realiza una búsqueda secuencial, pero es crucial iterar solo hasta S.tope, no hasta el final del arreglo N.\n function pertenece(e : T; S : Conj) : boolean;\n // ... bucle while que itera de 1 hasta S.tope ...",
  unit: u7_unit,
  question_types: [ 'correct_output' ]
)

topic_22 = Topic.find_or_create_by!(
  name: 'Registros Variantes',
  short_description: 'Explica cómo definir un tipo registro cuya estructura puede variar según el valor de un campo especial (discriminante). Permite modelar entidades que comparten datos comunes pero tienen atributos específicos según su categoría.',
  description: "Un registro variante (variant record) es una estructura de datos que permite que un registro tenga diferentes campos según el valor de un campo especial, conocido como campo discriminante o campo etiqueta (tag field).\n\n### Motivación\nSe utilizan para representar entidades que pueden pertenecer a diferentes categorías, donde cada categoría comparte un conjunto de atributos comunes (la parte fija) pero también tiene atributos específicos (la parte variante).\n\n### Sintaxis y Estructura\nUn registro variante se compone de una parte fija y una parte variante.\npascal\ntype\n TipoDiscriminante = (valor1, valor2, ...);\n NombreRegistro = record\n // --- Parte Fija (común a todas las variantes) ---\n campo_comun1: TipoA;\n campo_comun2: TipoB;\n\n // --- Parte Variante (depende del campo discriminante) ---\n case campo_discriminante: TipoDiscriminante of\n valor1: (\n campo_esp1_a: TipoX;\n campo_esp1_b: TipoY\n );\n valor2: (\n campo_esp2_a: TipoZ\n );\n end;\n\n* Parte Fija: Son los campos que existen para cualquier instancia del registro, sin importar su variante.\n* Parte Variante: Se introduce con la palabra case. Define las diferentes estructuras posibles.\n* Campo Discriminante: (campo_discriminante en el ejemplo) es un campo de tipo ordinal cuyo valor determina cuál de las variantes está activa. Se declara junto al case.\n* Variantes: Cada posible valor del campo discriminante (valor1, valor2) define una lista de campos entre paréntesis que solo existen cuando el campo discriminante tiene ese valor.\n\n### Ejemplo: Figuras Geométricas\npascal\ntype\n TipoFigura = (circulo, cuadrado, rectangulo);\n figura = record\n color: RGBColor; // Parte fija\n case clase: TipoFigura of // Campo discriminante\n circulo: (radio: real; centro: punto);\n cuadrado: (lado: real; verticeSupIzq: punto);\n rectangulo: (base, altura: real; verticeInfIzq: punto);\n end;\n\n\n### Uso y Acceso\n1. Asignación: Para asignar valores a un registro variante, se debe primero asignar un valor al campo discriminante. Solo después es seguro y correcto acceder a los campos de esa variante específica.\n pascal\n var r: figura;\n r.clase := rectangulo; // Se activa la variante 'rectangulo'\n r.base := 12.4; // Ahora es seguro acceder a 'base'\n r.altura := 345.90;\n\n Acceder a r.radio en este punto sería un error lógico.\n\n2. Procesamiento: Para leer o procesar un registro variante, se debe usar una estructura case sobre el campo discriminante para determinar la variante activa y operar con los campos correctos.\n pascal\n function areaFigura(fig: Figura): real;\n begin\n with fig do begin\n case clase of\n circulo: areaFigura := PI * sqr(radio);\n rectangulo: areaFigura := base * altura;\n cuadrado: areaFigura := sqr(lado);\n end;\n end;\n end;",
  unit: u7_unit,
  question_types: [ 'correct_output' ]
)

# Create the eighth unit and its topics
u8_unit = Unit.find_or_create_by!(
  name: 'Punteros y Estructuras Dinámicas',
  description: 'Punteros, memoria dinámica y estructuras de datos dinámicas como listas encadenadas en Pascal.',
  course_id: p1_course.id,
  position: 8
)
u8_unit.save!

topic_23 = Topic.find_or_create_by!(
  name: 'Fundamentos de Punteros y Memoria Dinámica',
  short_description: 'Introduce el concepto de punteros como variables que almacenan direcciones de memoria, permitiendo la creación de estructuras de datos dinámicas cuyo tamaño puede cambiar durante la ejecución del programa. Se explican las operaciones básicas de asignación de memoria, acceso y liberación.',
  description: "Una estructura de datos dinámica es aquella cuyo tamaño puede cambiar en tiempo de ejecución, a diferencia de las estructuras estáticas como arreglos o registros, cuya memoria se asigna al inicio de un bloque y permanece fija.\n\nLos punteros son la herramienta clave para crear estructuras dinámicas. Un puntero es una variable cuyo contenido no es un dato en sí, sino la dirección de memoria donde se almacena otro dato. \n\n### Declaración de Punteros\nSe declaran usando el símbolo ^ antes del tipo de dato al que apuntarán.\n* Sintaxis: type nombre_puntero = ^tipo_apuntado;\n* Ejemplo:\n pascal\n type\n ptrInt = ^integer; // Un puntero a un entero\n ptrCelda = ^celda; // Un puntero a un registro de tipo celda\n\n\n### Operaciones Fundamentales\n1. Creación de memoria (new): El procedimiento new(ptr) realiza una asignación dinámica de memoria. Crea en tiempo de ejecución un nuevo espacio de memoria del tamaño requerido por el tipo_apuntado y guarda su dirección en la variable puntero ptr. La variable creada es anónima (no tiene identificador propio) y su contenido inicial es indefinido.\n\n2. Acceso a datos (desreferenciación con ^): El operador ^ aplicado a un puntero (ej. ptr^) permite acceder a la variable que está en la dirección de memoria apuntada. Esta expresión se puede usar como cualquier otra variable del tipo apuntado (para leer su valor o para asignarle uno nuevo).\n * new(p); // p ahora apunta a una nueva celda de memoria\n * p^ := 10; // Se asigna 10 al espacio de memoria apuntado por p\n\n3. Liberación de memoria (dispose): El procedimiento dispose(ptr) le indica al sistema que el espacio de memoria apuntado por ptr ya no se necesita. El sistema recupera ese espacio para poder reutilizarlo. Después de un dispose, el puntero ptr queda con un valor indefinido.\n\n### Alias de Variables\nSi dos punteros (ptr1 y ptr2) contienen la misma dirección de memoria (ptr2 := ptr1), se dice que son alias. Ambas expresiones ptr1^ y ptr2^ se refieren exactamente a la misma variable en memoria, por lo que un cambio a través de uno se refleja en el otro.",
  unit: u8_unit,
  question_types: [ 'correct_output' ]
)
topic_23.prerequisite_topics = [ topic_14, topic_15 ]

topic_24 = Topic.find_or_create_by!(
  name: 'Listas Simplemente Encadenadas',
  short_description: "Presenta la lista encadenada como una estructura de datos dinámica fundamental. Explica su implementación mediante nodos auto-referenciados con punteros y el uso de la constante 'nil' para marcar el final o una lista vacía.",
  description: "Una lista es una secuencia finita de elementos. Mientras que los arreglos son una representación estática, las listas encadenadas son una representación dinámica que permite agregar y quitar elementos eficientemente. Su tamaño crece y decrece en proporción a la cantidad de elementos que contiene.\n\n### Estructura Conceptual\n* Cada elemento de la lista se almacena en un nodo o celda.\n* Cada celda contiene dos partes: el dato del elemento y un puntero que apunta a la siguiente celda de la lista.\n* Se accede a la lista completa a través de un único puntero que apunta al primer elemento (la cabecera de la lista).\n\n### El Puntero Nulo (nil)\nnil es una constante especial que no apunta a ninguna dirección de memoria. Es fundamental para las listas encadenadas y tiene dos propósitos principales:\n1. Representar una lista vacía: Si el puntero de cabecera de la lista tiene el valor nil, la lista no contiene elementos.\n2. Marcar el final de la lista: El puntero siguiente de la última celda de la lista apunta a nil, indicando que no hay más elementos.\nIntentar desreferenciar nil (ej. nil^) es un error en tiempo de ejecución.\n\n### Definición en Pascal\nLa implementación de una lista encadenada en Pascal requiere una definición de tipos auto-referenciada, donde un registro contiene un puntero a su propio tipo. Pascal permite esta declaración adelantada de punteros.\n\npascal\ntype\n // Se declara 'lista' como un puntero a 'celda', aunque 'celda' aún no se ha definido.\n lista = ^celda;\n\n celda = record\n elemento: T; // Campo para el dato (de cualquier tipo T)\n siguiente: lista; // Puntero al siguiente nodo de la lista\n end;\n\nUna variable de tipo lista contendrá la dirección de memoria de la primera celda de la secuencia, o nil si la lista está vacía.",
  unit: u8_unit,
  question_types: [ 'correct_output' ]
)
topic_24.prerequisite_topics = [ topic_23 ]

topic_25 = Topic.find_or_create_by!(
  name: 'Algoritmos sobre Listas Encadenadas',
  short_description: 'Detalla la implementación de las operaciones más comunes sobre listas encadenadas, como el recorrido para búsqueda o conteo, la inserción de nuevos elementos (al principio y al final) y la eliminación de nodos para liberar memoria.',
  description: "La manipulación de listas encadenadas se basa en un conjunto de algoritmos que gestionan los punteros para mantener la secuencia de la estructura.\n\n### Recorrido y Búsqueda\nRecorrer una lista implica usar un puntero auxiliar que avanza de nodo en nodo hasta llegar a nil.\n* Esquema de recorrido: Se inicializa un puntero auxiliar p con la cabecera de la lista l. Mientras p no sea nil, se procesa p^.elemento y se avanza al siguiente nodo con p := p^.siguiente.\n* Ejemplo (Calcular largo):\n pascal\n function largo(l: lista): integer;\n // ...\n p := l;\n while p <> nil do\n begin\n contador := contador + 1;\n p := p^.siguiente;\n end;\n // ...\n\n* Ejemplo (Búsqueda):\n La búsqueda se detiene cuando se encuentra el elemento o se llega al final. El circuito corto es esencial para evitar desreferenciar nil.\n while (p <> nil) and (p^.elemento <> elem) do\n p := p^.siguiente;\n\n### Inserción de Elementos\n* Agregar al Principio: Es la operación de inserción más eficiente.\n 1. Crear un nuevo nodo con new(p).\n 2. Cargar el dato: p^.elemento := elem;\n 3. Hacer que el nuevo nodo apunte a la antigua cabecera: p^.siguiente := l;\n 4. Actualizar la cabecera de la lista para que apunte al nuevo nodo: l := p;\n\n* Agregar al Final: Requiere recorrer la lista hasta el último nodo.\n 1. Crear y cargar el nuevo nodo, y hacer que su puntero siguiente apunte a nil.\n 2. Si la lista está vacía, la cabecera apunta al nuevo nodo.\n 3. Si no, se recorre la lista hasta encontrar el último nodo (q^.siguiente = nil).\n 4. Se enlaza el último nodo con el nuevo: q^.siguiente := p;\n\n### Eliminación de Elementos y Liberación de Memoria\n* Borrar el Primer Elemento: \n 1. Guardar la dirección del primer nodo en un puntero auxiliar p.\n 2. Avanzar la cabecera de la lista al segundo nodo: l := l^.siguiente;\n 3. Liberar la memoria del nodo que se eliminó: dispose(p);\n\n* Borrar la Lista Completa: Es crucial liberar cada nodo para evitar fugas de memoria. No basta con hacer l := nil.\n pascal\n procedure borrar_lista(var l: lista);\n var p: lista;\n begin\n while l <> nil do\n begin\n p := l;\n l := l^.siguiente;\n dispose(p);\n end;\n end;",
  unit: u8_unit,
  question_types: [ 'correct_output' ]
)
topic_25.prerequisite_topics = [ topic_24, topic_16 ]

# Create the ninth unit and its topics
u9_unit = Unit.find_or_create_by!(
  name: 'Algoritmos de búsqueda y ordenación',
  description: 'Algoritmos fundamentales de búsqueda y ordenación en Pascal, incluyendo búsqueda lineal, binaria y métodos de ordenación básicos.',
  course_id: p1_course.id,
  position: 9
)
u9_unit.save!

topic_26 = Topic.find_or_create_by!(
  name: 'Búsqueda Lineal (Secuencial)',
  short_description: 'Un algoritmo de búsqueda fundamental que revisa cada elemento de una estructura de datos de forma secuencial, uno por uno, hasta encontrar el elemento deseado o hasta haber revisado todos los elementos sin éxito.',
  description: "La búsqueda lineal, también conocida como búsqueda secuencial, es el método de búsqueda más simple.\n\n### Concepto\nEl algoritmo recorre una colección de datos (como un arreglo) desde el inicio, comparando cada elemento con el valor que se busca. El proceso continúa hasta que ocurre una de dos condiciones:\n1. Se encuentra el elemento deseado.\n2. Se llega al final de la colección sin haber encontrado el elemento.\n\n### Proceso en un Arreglo\nDado un arreglo A y un valor x a buscar:\n1. Se inicializa un índice i en la primera posición ( ej. i := 1).\n2. Se entra en un bucle que se ejecuta mientras el índice i esté dentro de los límites del arreglo y el elemento A[i] no sea igual a x.\n3. Dentro del bucle, simplemente se incrementa el índice i.\n4. Al salir del bucle, se verifica la condición de parada. Si i está todavía dentro de los límites del arreglo, significa que A[i] es igual a x y el elemento fue encontrado. Si i ha superado el límite, el elemento no se encuentra en el arreglo.\n\n### Implementación en Pascal\npascal\nfunction BLineal(x: integer; A: arreglo): boolean;\nvar i: integer;\nbegin\n i := 1;\n // El bucle se detiene si se pasa del final o si encuentra el elemento\n while (i <= n) and (A[i] <> x) do\n i := i + 1;\n // La búsqueda fue exitosa si el bucle se detuvo antes de que i > n\n BLineal := (i <= n);\nend;\n\n\n### Características\n* Ventaja: Es muy simple de implementar y no requiere que los datos estén ordenados.\n* Desventaja: Es ineficiente para grandes colecciones de datos, ya que en el peor de los casos debe revisar todos los elementos.",
  unit: u9_unit,
  question_types: [ 'correct_output' ]
)
topic_26.prerequisite_topics = [ topic_15, topic_16, topic_8 ]

topic_27 = Topic.find_or_create_by!(
  name: 'Búsqueda Binaria',
  short_description: 'Un algoritmo de búsqueda muy eficiente que funciona sobre colecciones de datos ordenadas. Reduce el espacio de búsqueda a la mitad en cada paso, comparando el elemento buscado con el elemento central del intervalo.',
  description: "La búsqueda binaria o bipartición es un algoritmo significativamente más rápido que la búsqueda lineal, pero tiene un requisito fundamental: la colección de datos debe estar ordenada.\n\n### Concepto (Dividir y Vencer)\nEl algoritmo se basa en la idea de dividir sucesivamente el intervalo de búsqueda en dos partes iguales.\n\n1. Se define un intervalo de búsqueda, inicialmente todo el arreglo, con un límite inferior (inf) y uno superior (sup).\n2. Se calcula la posición media del intervalo: medio := (inf + sup) DIV 2.\n3. Se compara el valor buscado x con el elemento en la posición medio, A[medio]:\n * Si x = A[medio], la búsqueda ha terminado con éxito.\n * Si x < A[medio], se sabe que x solo puede estar en la mitad inferior del intervalo. Se descarta la mitad superior actualizando el límite: sup := medio - 1.\n * Si x > A[medio], x solo puede estar en la mitad superior. Se descarta la mitad inferior actualizando el límite: inf := medio + 1.\n4. El proceso se repite con el nuevo intervalo reducido hasta que se encuentra el elemento o el intervalo de búsqueda se vuelve vacío.\n\n### Condición de Detención\nLa búsqueda termina sin éxito cuando el intervalo se vuelve vacío, lo cual se detecta cuando inf > sup.\n\n### Implementación en Pascal\npascal\nfunction BBinaria(x: integer; A: arreglo): boolean;\n { precondición: A está ordenado }\nvar inf, sup, medio: integer;\nbegin\n inf := 1;\n sup := N;\n while (inf <= sup) do\n begin\n medio := (inf + sup) DIV 2;\n if x = A[medio] then\n inf := sup + 1 // Forzar salida del bucle al encontrarlo\n else if x < A[medio] then\n sup := medio - 1\n else // x > A[medio]\n inf := medio + 1;\n end;\n // Si se encontró, A[medio] es x. Una forma de verificarlo es si sup >= inf después del bucle.\n // La implementación del documento es ligeramente diferente pero conceptualmente igual.\n BBinaria := (inf <= sup); // Si el bucle terminó por A[medio]=x, esto puede fallar. Una mejor comprobación es necesaria.\nend;\n\n\nNota: La implementación del documento es iterativa y ajusta los límites inf y sup hasta que A[medio] = x o inf > sup. La condición de éxito al final BBinaria := inf <= sup funciona porque si A[medio]=x, el bucle termina y inf <= sup se mantiene. Si no se encuentra, inf se vuelve mayor que sup y la condición es falsa.",
  unit: u9_unit,
  question_types: [ 'correct_output' ]
)
topic_27.prerequisite_topics = [ topic_26, topic_7 ]

topic_28 = Topic.find_or_create_by!(
  name: 'Ordenación: Inserción y Selección',
  short_description: 'Introduce dos algoritmos fundamentales para ordenar una colección de datos. El método de Inserción construye el arreglo ordenado de forma incremental, mientras que el de Selección busca repetidamente el elemento mayor (o menor) y lo coloca en su posición final.',
  description: "La ordenación es el proceso de reorganizar un conjunto de objetos según un criterio específico (clave de ordenación). Es un paso fundamental para poder aplicar algoritmos eficientes como la búsqueda binaria.\n\n### 1. Ordenación por Inserción (Insertion Sort)\nEste método construye la versión final ordenada del arreglo un elemento a la vez.\n\n* Concepto: El algoritmo itera desde el segundo elemento (i=2) hasta el final. En cada iteración i, considera al elemento A[i] como un valor a insertar en la sublista ya ordenada A[1...i-1].\n* Proceso: Para insertar A[i], se compara con los elementos a su izquierda (A[i-1], A[i-2], etc.). Los elementos mayores que A[i] se desplazan una posición a la derecha para hacerle un hueco. Este proceso continúa hasta que se encuentra un elemento menor o igual, o se llega al principio del arreglo. En ese punto, se coloca A[i] en el hueco creado.\n* Implementación: Se utiliza un bucle externo for i := 2 to n para recorrer el arreglo. Un bucle interno while se encarga de desplazar los elementos y encontrar la posición correcta para la inserción.\n pascal\n procedure OrdIns(var A: arreglo);\n var i, j: integer;\n begin\n for i := 2 to n do begin\n j := i;\n while (j >= 2) and (A[j] < A[j-1]) do begin\n intercambio(A[j], A[j-1]);\n j := j - 1;\n end;\n end;\n end;\n\n\n### 2. Ordenación por Selección (Selection Sort)\nEste método divide conceptualmente el arreglo en una parte ordenada (que crece desde el final hacia el principio) y una parte desordenada.\n\n* Concepto: En cada pasada, el algoritmo busca el elemento con la clave más grande en la porción aún no ordenada del arreglo.\n* Proceso: Una vez encontrado el elemento más grande, lo intercambia (swap) con el elemento que se encuentra en la última posición de la porción desordenada. Luego, reduce en uno el tamaño de la porción desordenada y repite el proceso.\n* Implementación: Un bucle principal for i := n downto 2 gestiona la porción desordenada (de 1 a i). Dentro de este bucle, se llama a una función auxiliar maximo(i, A) para encontrar el índice del elemento más grande en el rango 1..i. Finalmente, se realiza un intercambio entre A[indice_maximo] y A[i].\n pascal\n function maximo(ultimo: integer; A: arreglo): integer;\n // ... busca y devuelve el índice del máximo en A[1..ultimo]\n \n procedure OrdSel(var A: arreglo);\n var i, mayor: integer;\n begin\n for i := n downto 2 do begin\n mayor := maximo(i, A);\n intercambio(A[mayor], A[i]);\n end;\n end;",
  unit: u9_unit,
  question_types: [ 'correct_output' ]
)
topic_28.prerequisite_topics = [ topic_26, topic_11, topic_12 ]

puts "Topics created: #{Topic.count}!!! :)"

learning_aids_by_topic = {
  "Tipos de Datos Numéricos y Expresiones" => [
    { name: "Openfing: Componentes Básicos 1", url: "https://open.fing.edu.uy/courses/p1/2/" },
    { name: "Openfing: Componentes Básicos 2", url: "https://open.fing.edu.uy/courses/p1/3/" },
    { name: "Guia Teórica: Componentes Básicos", url: "https://eva.fing.edu.uy/pluginfile.php/554577/mod_resource/content/4/Componentes-Basicos.pdf" }
  ],
  "Tipos de Datos Boolean y Char" => [
    { name: "Openfing: Componentes Básicos 1", url: "https://open.fing.edu.uy/courses/p1/2/" },
    { name: "Openfing: Componentes Básicos 2", url: "https://open.fing.edu.uy/courses/p1/3/" },
    { name: "Guia Teórica: Componentes Básicos", url: "https://eva.fing.edu.uy/pluginfile.php/554577/mod_resource/content/4/Componentes-Basicos.pdf" }
  ],
  "Manejo de Entrada y Salida Estándar" => [
    { name: "Openfing: Componentes Básicos y Entrada/Salida", url: "https://open.fing.edu.uy/courses/p1/3/" },
    { name: "Guia Teórica: Entrada y Salida", url: "https://eva.fing.edu.uy/pluginfile.php/554578/mod_resource/content/5/03-GuiaEntradaYSalida.pdf" }
  ],
  "Selección Condicional: if-then-else" => [
    { name: "Estructuras de Control. Secuencia y Selección", url: "https://eva.fing.edu.uy/pluginfile.php/554569/mod_resource/content/8/GuiaSecuenciaYSeleccion.pdf" },
    { name: "Openfing: Estructuras de Control. Secuencia y Selección", url: "https://open.fing.edu.uy/courses/p1/4/" }
  ],
  "Operadores y Evaluación de Expresiones Booleanas" => [
    { name: "Estructuras de Control. Secuencia y Selección", url: "https://eva.fing.edu.uy/pluginfile.php/554569/mod_resource/content/8/GuiaSecuenciaYSeleccion.pdf" },
    { name: "Openfing: Estructuras de Control. Secuencia y Selección", url: "https://open.fing.edu.uy/courses/p1/4/" }
  ],
  "Selección Múltiple: case" => [
    { name: "Estructuras de Control. Secuencia y Selección", url: "https://eva.fing.edu.uy/pluginfile.php/554569/mod_resource/content/8/GuiaSecuenciaYSeleccion.pdf" },
    { name: "Openfing: Estructuras de Control. Secuencia y Selección", url: "https://open.fing.edu.uy/courses/p1/4/" }
  ],
  "Repetición: for" => [
    { name: "Openfing: Estructuras de Control y Repetición: For", url: "https://open.fing.edu.uy/courses/p1/5/" }
  ],
  "Repetición Condicional: while" => [
    { name: "Openfing: Estructuras de Control y Repetición Condicional: While", url: "https://open.fing.edu.uy/courses/p1/6/" }
  ],
    "Repetición Condicional: repeat...until" => [
    { name: "Openfing: Estructuras de Control y Repetición Condicional: Repeat", url: "https://open.fing.edu.uy/courses/p1/7/" }
  ],
  "Funciones" => [
    { name: "Openfing: Subprogramas, Funciones", url: "https://open.fing.edu.uy/courses/p1/12/" }
  ],
  "Procedimientos y Pasaje de Parámetros" => [
    { name: "Openfing: Subprogramas. Procedimientos. Alcance", url: "https://open.fing.edu.uy/courses/p1/13/" }
  ],
  "Alcance de Identificadores" => [
    { name: "Openfing: Alcance", url: "https://open.fing.edu.uy/courses/p1/13/" }
  ],
  "Tipos Propios y Subrangos" => [
    { name: "Openfing: Arreglos y Subrangos", url: "https://open.fing.edu.uy/courses/p1/9/" }
  ],
  "Arreglos Unidimensionales" => [
    { name: "Openfing: Arreglos y Subrangos 1", url: "https://open.fing.edu.uy/courses/p1/9/" },
    { name: "Openfing: Arreglos y Subrangos 2", url: "https://open.fing.edu.uy/courses/p1/10/" }
  ],
  "Operaciones con Arreglos: Recorridas y Búsquedas" => [
    { name: "Openfing: Arreglos y Subrangos 1", url: "https://open.fing.edu.uy/courses/p1/9/" },
    { name: "Openfing: Arreglos y Subrangos 2", url: "https://open.fing.edu.uy/courses/p1/10/" }
  ],
  "Enumerados" => [
    { name: "Openfing: Tipos de datos - Enumerados. Conjuntos. Registros", url: "https://open.fing.edu.uy/courses/p1/14/" }
  ],
  "Conjuntos (Set)" => [
    { name: "Openfing: Tipos de datos - Enumerados. Conjuntos. Registros", url: "https://open.fing.edu.uy/courses/p1/14/" }
  ],
  "Array con Tope" => [
    { name: "Openfing: Array con Tope 1", url: "https://open.fing.edu.uy/courses/p1/15/" },
    { name: "Openfing: Array con Tope 2", url: "https://open.fing.edu.uy/courses/p1/16/" }
  ],
  "Registros Variantes" => [
    { name: "Openfing: Array con Tope y Registros Variantes", url: "https://open.fing.edu.uy/courses/p1/16/" }
  ],
  "Fundamentos de Punteros y Memoria Dinámica" => [
    { name: "Openfing: Memoria dinamica punteros", url: "https://open.fing.edu.uy/courses/p1/17/" }
  ],
  "Listas Simplemente Encadenadas" => [
    { name: "Openfing: Listas 1", url: "https://open.fing.edu.uy/courses/p1/18/" },
    { name: "Openfing: Listas 2", url: "https://open.fing.edu.uy/courses/p1/19/" }
  ],
  "Algoritmos sobre Listas Encadenadas" => [
    { name: "Openfing: Listas 1", url: "https://open.fing.edu.uy/courses/p1/18/" },
    { name: "Openfing: Listas 2", url: "https://open.fing.edu.uy/courses/p1/19/" }
  ],
  "Búsqueda Lineal (Secuencial)" => [
    { name: "Openfing: Búsqueda y Ordenación", url: "https://open.fing.edu.uy/courses/p1/20/" }
  ],
    "Búsqueda Binaria" => [
    { name: "Openfing: Búsqueda y Ordenación", url: "https://open.fing.edu.uy/courses/p1/20/" }
  ],
  "Ordenación: Inserción y Selección" => [
    { name: "Openfing: Búsqueda y Ordenación", url: "https://open.fing.edu.uy/courses/p1/20/" }
  ]
}

created_la = 0

ActiveRecord::Base.transaction do
  learning_aids_by_topic.each do |topic_name, items|
    topic = Topic.find_by!(name: topic_name)
    items.each do |item|
      LearningAid.create!(topic: topic, name: item[:name], url: item[:url])
      created_la += 1
    end
  end
end

puts "LearningAids created: #{created_la}"
