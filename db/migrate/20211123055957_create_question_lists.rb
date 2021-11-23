class CreateQuestionLists < ActiveRecord::Migration[6.1]
  def change
    create_table :question_lists do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.string :visiblity
      t.references :forked_from, foreign_key: {to_table: :question_lists}

      t.timestamps
    end
  end
end
