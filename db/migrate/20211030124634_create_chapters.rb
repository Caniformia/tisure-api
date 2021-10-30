class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.string :name
      t.references :subject, null: false, foreign_key: true
    end
  end
end
