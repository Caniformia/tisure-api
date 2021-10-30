class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :content
      t.boolean :is_answer
      t.references :question, null: false, foreign_key: true
    end
  end
end
