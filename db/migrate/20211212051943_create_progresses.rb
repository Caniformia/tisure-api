class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :subject, null: false, foreign_key: { on_delete: :cascade }
      t.references :last_accessed_question, foreign_key: { to_table: :questions, on_delete: :nullify }

      t.timestamps
    end

    add_index :progresses, [:user_id, :subject_id], unique: true
  end
end
