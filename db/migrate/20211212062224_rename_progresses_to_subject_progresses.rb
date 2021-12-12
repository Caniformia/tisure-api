class RenameProgressesToSubjectProgresses < ActiveRecord::Migration[6.1]
  def change
    rename_table :progresses, :subject_progresses
  end
end
