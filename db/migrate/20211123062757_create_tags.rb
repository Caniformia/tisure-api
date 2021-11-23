class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end

    add_index :tags, [:name, :user_id, :question_id], unique: true
  end
end
