class FixQuestionListVisibility < ActiveRecord::Migration[6.1]
  def change
    remove_column :question_lists, :visiblity
    add_column :question_lists, :visibility, :integer
    change_column_null :question_lists, :visibility, false, 0
  end
end
