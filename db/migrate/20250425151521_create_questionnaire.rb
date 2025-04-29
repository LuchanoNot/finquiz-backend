class CreateQuestionnaire < ActiveRecord::Migration[8.0]
  def change
    create_table :questionnaires do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.integer :current_position, null: false, default: 0

      t.timestamps
    end
  end
end
