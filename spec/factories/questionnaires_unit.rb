FactoryBot.define do
  factory :questionnaires_unit do
    questionnaire { create(:questionnaire) }
    unit { create(:unit) }
  end
end
