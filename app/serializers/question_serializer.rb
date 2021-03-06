class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :content, :is_multi_answer, :chapter_id, :image_url, :question_lists
  has_many :choices
  has_many :comments

  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  def question_lists
    object.question_lists.where owner: scope if scope.is_a? User
  end
end
