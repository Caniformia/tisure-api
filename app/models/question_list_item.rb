class QuestionListItem < ApplicationRecord
  belongs_to :question
  belongs_to :question_list
end
