class QuestionListSerializer < ActiveModel::Serializer
  attributes :id, :name, :visibility
  has_one :owner
  has_one :forked_from
  has_many :question_list_items
end
