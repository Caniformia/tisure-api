class QuestionListItemSerializer < ActiveModel::Serializer
  attributes :id, :question_list_id
  has_one :question
end
