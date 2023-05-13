class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end
  
end
