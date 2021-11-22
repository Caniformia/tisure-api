class Record < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_and_belongs_to_many :choices
end
