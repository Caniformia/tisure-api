class SubjectProgress < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  belongs_to :last_accessed_chapter, class_name: :Chapter, optional: true
end
