puts 'seeding questionnaires...'

estudiante1 = User.find_by(nickname: 'estudiante1')

questionnaire = Questionnaire.find_or_create_by!(
  user: estudiante1,
)

5.times do |i|
  question = questionnaire.questions.create!(stem: "Seeded question #{i}", generating: false)

  3.times do |j|
    question.reload.options.create!(text: "Option #{j}", correct: j == 0, explanation: "Explanation #{j}")
  end
end

puts 'questionnaires seeded successfully!'
