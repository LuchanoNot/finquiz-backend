# frozen_string_literal: true

Course.find_or_create_by!(name: "Programación 1") do |course|
  course.description = "Curso de Programación 1"
end
Course.find_or_create_by!(name: "NeoCourse") do |course|
  course.description = "Curso de programación en Ruby on Rails"
end

puts "Courses seed executed successfully! :)"
