class Question < ApplicationRecord
  belongs_to :chapter
  has_many :choices
  has_many :records
  has_one_attached :image
  has_many :comments

  has_many :question_list_items
  has_many :question_lists, through: :question_list_items
end
