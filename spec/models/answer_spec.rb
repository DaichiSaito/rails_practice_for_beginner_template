require 'rails_helper'

RSpec.describe Answer, type: :model do
  # ユーザー、質問、回答内容があれば有効な状態になること
  it 'is valid with user, question and body' do
    answer = build(:answer)
    
    expect(answer).to be_valid
  end

  # 質問内容がなければ無効な状態になること
  it 'is invalid without body' do
    answer = build(:answer, body: nil)

    answer.valid?
    expect(answer.errors[:body]).to include("can't be blank")
  end
end
