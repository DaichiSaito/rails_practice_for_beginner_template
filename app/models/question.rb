class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, presence: true, length: {minimum:1, maximum:30}
  validates :body, presence: true
end
