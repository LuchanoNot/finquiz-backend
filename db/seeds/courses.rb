
Course.find_or_create_by!(
    name: 'Programación 1',
    description: 'Curso de Programación 1',
)
Course.find_or_create_by!(
    name: 'NeoCourse',
    description: 'Curso de programación en Ruby on Rails',
)

puts "Courses seed executed successfully! :)"
