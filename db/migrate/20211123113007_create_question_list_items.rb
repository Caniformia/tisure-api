class CreateQuestionListItems < ActiveRecord::Migration[6.1]
  def change
    create_table :question_list_items do |t|
      t.belongs_to :question, null: false, foreign_key: true
      t.belongs_to :question_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
