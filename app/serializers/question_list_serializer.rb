class QuestionListSerializer < ActiveModel::Serializer
  attributes :id, :name, :visibility, :share_link, :question_count
  has_one :owner
  has_one :forked_from
  has_many :question_list_items

  def question_count
    object.question_list_items.count
  end
end
