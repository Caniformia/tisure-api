class QuestionListSerializer < ActiveModel::Serializer
  attributes :id, :name, :visiblity
  has_one :owner
  has_one :forked_from
end
