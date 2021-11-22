class ChangeColumnsNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :subjects, :name, false, ''
    change_column_null :chapters, :name, false, ''
    change_column_null :questions, :content, false, ''
    change_column_null :questions, :is_multi_answer, false, true
    change_column_null :choices, :content, false, ''
    change_column_null :choices, :is_answer, false, false
    change_column_null :records, :is_correct, false, false
  end
end
