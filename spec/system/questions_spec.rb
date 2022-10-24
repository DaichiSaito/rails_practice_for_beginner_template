require 'rails_helper'

RSpec.describe "Questions", type: :system do
  before do
    driven_by(:rack_test)
  end

  # 基本操作
  describe "basic oparation" do
    before do
      @user = create(:user)
    end
    # 質問する
    it "questions as user" do
      sign_in_as(@user)
      visit root_path

      expect {
        click_link "質問作成"
        fill_in "タイトル", with: "question1"
        fill_in "質問内容", with: "teach me"
        click_button "質問する"

        expect(page).to have_content "作成しました"
        expect(page).to have_content "question1"
        expect(page).to have_content "kosuke"
      }.to change(@user.questions, :count).by(1)

    end

    # 回答する
    it "answers as user" do
      question = create(:question, user: @user, title: "question1")

      sign_in_as(@user)
      visit root_path
      click_link "question1"
      
      fill_in "回答内容", with: "rails tutorial"
      click_button "回答する"

      expect(page).to have_content "回答しました"
      expect(page).to have_content "rails tutorial"
    end

    # 質問を更新する
    it "updates question as user" do
      question = create(:question, user: @user, title: "question1")

      sign_in_as(@user)
      visit questions_path
      
      click_link "編集"
      fill_in "タイトル", with: "question2"
      fill_in "質問内容", with: "teach!"
      click_button "更新する"

      expect(page).to have_content "更新しました"
      expect(page).to have_content "question2"
    end

    # 質問を削除する
    it "deletes question" do
      create(:question, title: "question1", user: @user)

      sign_in_as(@user)
      visit questions_path
      
      click_link "削除"
      expect(page).to have_content "削除しました"
      expect(page).to_not have_content "question1"
    end
  end

  # 質問の絞り込み
  describe "when user narrows questions" do
    before do
      @user = create(:user)
      sign_in_as(@user)
      @question1 = create(:question, title: "question1",user: @user)
      @question2 = create(:question, title: "question2", user: @user, solved: true)
    end

    # 全て,未解決,解決済み
    it "shows questions" do
      visit questions_path
      
      expect(page).to have_content "question1"
      expect(page).to have_content "question2"

      click_link "未解決"
      expect(page).to have_content "question1"

      click_link "解決"
      expect(page).to have_content "question2"
    end
  end


  pending "add some scenarios (or delete) #{__FILE__}"
end
