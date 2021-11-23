class ChangeQListNameVisiblityNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :question_lists, :name, false, ''
    change_column_null :question_lists, :visiblity, false, 'private'
  end
end
