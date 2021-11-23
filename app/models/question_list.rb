class QuestionList < ApplicationRecord
  belongs_to :owner, foreign_key: "owner_id", class_name: "User"
  belongs_to :forked_from, foreign_key: "forked_from_id", class_name: "QuestionList", optional: true
end
