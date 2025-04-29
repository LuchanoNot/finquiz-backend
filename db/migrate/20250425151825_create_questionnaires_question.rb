class CreateQuestionnairesQuestion < ActiveRecord::Migration[8.0]
  def change
    create_table :questionnaires_questions do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answered_option, null: true, foreign_key: { to_table: :options }

      t.integer :position, null: false, default: 0


      t.timestamps
    end
  end
end
