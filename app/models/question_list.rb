class QuestionList < ApplicationRecord
  enum visibility: [:private, :public], _prefix: true

  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  belongs_to :forked_from, foreign_key: "forked_from_id", class_name: "QuestionList", optional: true

  has_many :question_list_items
  has_many :questions, through: :question_list_items
end
