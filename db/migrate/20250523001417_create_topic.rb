class CreateTopic < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.text :description
      t.string :short_description
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
