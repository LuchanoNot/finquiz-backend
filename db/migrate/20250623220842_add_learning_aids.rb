class AddLearningAids < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_aids do |t|
      t.string :name
      t.string :url
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
