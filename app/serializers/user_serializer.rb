class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :is_admin, :nickname
  has_one :last_accessed_subject
end
