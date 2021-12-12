class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :is_admin, :nickname
end
