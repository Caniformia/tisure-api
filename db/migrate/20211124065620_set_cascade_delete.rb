class SetCascadeDelete < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :comments, :questions
    add_foreign_key :comments, :questions, on_delete: :cascade

    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade

    remove_foreign_key :question_list_items, :question_lists
    add_foreign_key :question_list_items, :question_lists, on_delete: :cascade

    remove_foreign_key :question_list_items, :questions
    add_foreign_key :question_list_items, :questions, on_delete: :cascade

    remove_foreign_key :question_lists, :question_lists, column: :forked_from_id
    add_foreign_key :question_lists, :question_lists, column: :forked_from_id, on_delete: :nullify

    remove_foreign_key :question_lists, :users, column: :owner_id
    add_foreign_key :question_lists, :users, column: :owner_id, on_delete: :cascade

    remove_foreign_key :records, :questions
    add_foreign_key :records, :questions, on_delete: :cascade

    remove_foreign_key :records, :users
    add_foreign_key :records, :users, on_delete: :cascade

    remove_foreign_key :tags, :questions
    add_foreign_key :tags, :questions, on_delete: :cascade

    remove_foreign_key :tags, :users
    add_foreign_key :tags, :users, on_delete: :cascade
  end
end
