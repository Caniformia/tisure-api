# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :records
  has_many :comments
  has_many :question_lists, foreign_key: "owner_id"
  has_many :tags
  belongs_to :last_accessed_subject, class_name: :Subject, optional: true
end
