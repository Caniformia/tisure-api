class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :content
      t.boolean :is_multi_answer
      t.references :chapter, null: false, foreign_key: true
    end
  end
end
