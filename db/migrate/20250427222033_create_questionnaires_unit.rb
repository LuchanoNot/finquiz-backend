class CreateQuestionnairesUnit < ActiveRecord::Migration[8.0]
  def change
    create_table :questionnaires_units do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :questionnaire, null: false, foreign_key: true

      t.timestamps
    end
  end
end
