class AddQuestionTypesToTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, :question_types, :text, array: true, default: []
  end
end
