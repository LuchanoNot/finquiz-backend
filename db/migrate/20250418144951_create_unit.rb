class CreateUnit < ActiveRecord::Migration[8.0]
  def change
    create_table :units do |t|
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.references :course, null: false, foreign_key: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
