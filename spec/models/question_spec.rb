require 'rails_helper'

RSpec.describe Question, type: :model do
  # 有効な属性の場合
  context "when attribute is valid" do
    # ユーザー、タイトル、内容があれば有効な状態になること
    it "is valid with title and body" do
      question = create(:question)

      expect(question).to be_valid
    end
  end

  # 無効な属性の場合
  context "when attribute is invalid" do
    # タイトルがなければ無効な状態になること
    it "is invalid without title" do
      question = build(:question, title: nil)
      question.valid?

      expect(question.errors[:title]).to include("can't be blank")
    end

    # 内容がなければ無効な状態になること
    it "is invalid without body" do
      question = build(:question, body: nil)
      question.valid?

      expect(question.errors[:body]).to include("can't be blank")
    end

    # タイトルが50文字以内でなければ無効な状態になること
    it "is invalid with title of 51 characters or more" do
      question = build(:question, title: "a"*51)
      question.valid?
      
      expect(question.errors[:title].first).to include("is too long")
    end

    # ユーザー単位では重複したタイトルを許可しないこと
    it "doesn't allow duplicate title per user" do
      question = create(:question, title: "question1")

      new_question = build(:question, title: "question1", user_id: 1)
      
      new_question.valid?
      expect(new_question.errors[:title].first).to include("has already been taken")
    end

    # 二人のユーザーが同じタイトルを使うことは許可すること
    it "allows two users to share question title" do
      create(:question, title: "question1")

      other_question = create(:question, title: "question1")
      
      expect(other_question).to be_valid
    end
  end

  # たくさんの回答が付いていること
  it "has many answers" do
    question = create(:question, :with_answers)

    expect(question.answers.length).to eq 5
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
