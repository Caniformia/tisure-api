class QuestionListItemSerializer < ActiveModel::Serializer
  attributes :id
  has_one :question
  has_one :question_list
end
