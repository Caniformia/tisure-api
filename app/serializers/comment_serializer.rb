class CommentSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :content, :created_at, :updated_at
  has_one :user
end
