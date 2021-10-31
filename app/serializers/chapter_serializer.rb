class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :questions, serializer: ChapterQuestionSerializer
end
