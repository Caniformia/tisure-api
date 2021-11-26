class AddShareLinkToQuestionLists < ActiveRecord::Migration[6.1]
  def change
    add_column :question_lists, :share_link, :string
  end
end
