class CreateChapterProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :chapter_progresses do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :chapter, null: false, foreign_key: { on_delete: :cascade }
      t.references :last_accessed_question, foreign_key: { to_table: :questions, on_delete: :nullify }

      t.timestamps
    end

    add_index :chapter_progresses, [:user_id, :chapter_id], unique: true

    remove_reference :subject_progresses, :last_accessed_question, foreign_key: { to_table: :questions }
    add_reference :subject_progresses, :last_accessed_chapter, foreign_key: { to_table: :chapters, on_delete: :nullify }
  end
end
