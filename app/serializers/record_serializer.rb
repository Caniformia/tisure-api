class RecordSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :is_correct, :question_id
  has_many :choice_ids
end
