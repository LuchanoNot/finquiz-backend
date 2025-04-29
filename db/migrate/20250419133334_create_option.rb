class CreateOption < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.text :text, null: false, default: ""
      t.boolean :correct, null: false, default: false
      t.text :explanation, null: false, default: ""
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
