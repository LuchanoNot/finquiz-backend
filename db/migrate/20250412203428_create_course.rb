class CreateCourse < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :description, null: false, default: ''
      t.timestamps
    end
  end
end
