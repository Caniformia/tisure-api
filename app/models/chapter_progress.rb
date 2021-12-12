class ChapterProgress < ApplicationRecord
  belongs_to :user
  belongs_to :chapter
  belongs_to :last_accessed_question, class_name: :Question, optional: true
end
