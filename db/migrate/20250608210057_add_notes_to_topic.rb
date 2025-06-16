class AddNotesToTopic < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, :notes, :text, null: true, default: ""
  end
end
