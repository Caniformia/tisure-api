class RecordSerializer < ActiveModel::Serializer
  attributes :id, :created_at
  has_one :question
end
