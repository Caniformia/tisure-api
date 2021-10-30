class Question < ApplicationRecord
  belongs_to :chapter
  has_many :choices
  has_one_attached :image
end
