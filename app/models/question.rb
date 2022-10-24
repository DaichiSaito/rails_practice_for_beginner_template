class Question < ApplicationRecord
  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id
  has_many :answers, dependent: :destroy

  validates :title,
    presence: true,
    length: { maximum: 50 },
    uniqueness: { scope: :user_id }
  validates :body, presence: true

  
end
