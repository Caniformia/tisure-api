class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :question_ids
end
