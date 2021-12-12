class SubjectProgressSerializer < ActiveModel::Serializer
  attributes :progress_count, :total_count, :updated_at
  has_one :last_accessed_chapter

  def progress_count
    object.user.records.joins(question: [:chapter])
      .where('chapters.subject_id' => object.subject.id).distinct.count(:question_id)
  end

  def total_count
    Question.joins(:chapter).where('chapters.subject_id' => object.subject.id).count
  end
end
