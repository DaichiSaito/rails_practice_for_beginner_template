require 'rails_helper'

RSpec.describe 'SignupSignins', type: :system do
  describe 'サインアップ' do
    it 'サインアップができること' do
      expect do
        visit '/users/new'
        fill_in '名前', with: 'kosuke'
        fill_in 'メールアドレス', with: 'kosuke@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
      end.to change(User, :count).by(1)
      expect(current_path).to eq '/questions'
      expect(page).to have_content 'サインアップが完了しました'
    end
  end

  describe 'サインイン' do
    let!(:user) { create(:user, email: 'kosuke@example.com', password: 'password') }
    it 'サインインできること' do
      visit '/login'
      fill_in 'メールアドレス', with: 'kosuke@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'

      expect(current_path).to eq '/questions'
      expect(page).to have_content 'ログインしました'
    end
  end
end
