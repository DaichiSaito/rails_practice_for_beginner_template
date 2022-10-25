require 'rails_helper'

describe User do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
end

RSpec.describe User, type: :model do
  # 有効な属性の場合
  context 'when attribute is valid' do
    # 名前、メール、パスワードがあれば有効な状態になること
    it 'is valid with a name, email and password' do
      user = build(:user)

      expect(user).to be_valid
    end
  end

  # 無効な属性の場合
  context 'when attribute is invalid' do
    # 名前がなければ無効な状態になること
    it 'is invalid without name' do
      user = build(:user, name: nil)
      user.valid?

      expect(user.errors[:name]).to include("can't be blank")
    end

    # メールがなければ無効な状態になること
    it 'is invalid without email' do
      user = build(:user, email: nil)

      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # パスワードがなければ無効な状態になること
    it 'is invalid without password_digest' do
      user = build(:user, password: nil)
      user.valid?

      expect(user.errors[:password]).to include("can't be blank")
    end

    # 重複したメールアドレスなら無効な状態であること
    it 'is invalid with duplicate email address' do
      create(:user, email: 'kosuke@example.com')
      user = build(:user, email: 'kosuke@example.com')
      user.valid?

      expect(user.errors[:email]).to include('has already been taken')
    end
  end
end
