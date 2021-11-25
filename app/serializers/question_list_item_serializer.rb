class QuestionListItemSerializer < ActiveModel::Serializer
  attributes :id, :question_list_id, :question_id
end
