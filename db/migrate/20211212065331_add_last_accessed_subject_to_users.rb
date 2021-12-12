class AddLastAccessedSubjectToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :last_accessed_subject, foreign_key: { to_table: :subjects, on_delete: :nullify }
  end
end
