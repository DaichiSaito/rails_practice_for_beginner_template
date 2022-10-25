class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  scope :related_to_question, ->(question) { joins(:answers).where(answers: { question_id: question.id }) }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def mine?(object)
    object.user_id == id
  end
end
