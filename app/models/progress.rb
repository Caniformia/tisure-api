class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  belongs_to :last_accessed_question, class_name: :Question, optional: true
end
