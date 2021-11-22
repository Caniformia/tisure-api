class RecordSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :is_correct
  has_one :question
  has_many :choices
end
