# frozen_string_literal: true

p1_course = Course.find_or_create_by!(name: "Programación 1") do |course|
  course.description = "Curso de Programación 1"
end

Unit.find_or_create_by!(
  name: 'Introducción a la programación',
  description: 'Introducción a la programación con Pascal, incluyendo variables, tipos de datos y estructuras de control.',
  course: p1_course,
  position: 0,
)
Unit.find_or_create_by!(
  name: 'Estructuras de control',
  description: 'Estructuras de control en Pascal, incluyendo condicionales y bucles.',
  course: p1_course,
  position: 1,
)
Unit.find_or_create_by!(
  name: 'Funciones y procedimientos',
  description: 'Funciones y procedimientos en Pascal, incluyendo parámetros y retorno de valores.',
  course: p1_course,
  position: 2,
)

puts "Units seed executed successfully! :)"
