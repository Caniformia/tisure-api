class AddIsCorrectToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :is_correct, :boolean
  end
end
