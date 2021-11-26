class AddIndexToQuestionListItems < ActiveRecord::Migration[6.1]
  def change
    add_index :question_list_items, [:question_list_id, :question_id], unique: true
  end
end
