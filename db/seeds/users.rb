# frozen_string_literal: true

puts 'Seeding users...'

User.create(
  [
    {
      name: 'Estudiante 1',
      nickname: 'estudiante1',
      email: 'estudiante1@example.com',
      password: 'password',
      role: :student
    },
    {
      name: 'Estudiante 2',
      nickname: 'estudiante2',
      email: 'estudiante2@example.com',
      password: 'password',
      role: :student
    },
    {
      name: 'Profesor 1',
      nickname: 'profesor1',

      email: 'profesor1@example.com',
      password: 'password',
      role: :teacher
    }
  ]
)

puts 'Users seeded successfully!'
