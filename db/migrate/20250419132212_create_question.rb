class CreateQuestion < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.text :stem, null: false, default: ""
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
