
Course.find_or_create_by!(
    name: 'Programación 1',
    description: 'Introducción a la programación con Pascal',
)
Course.find_or_create_by!(
    name: 'NeoCourse',
    description: 'Curso de programación en Ruby on Rails',
)

puts "Courses seeds executed successfully! :)"
