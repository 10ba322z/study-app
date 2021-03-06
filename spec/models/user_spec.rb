require 'rails_helper'

RSpec.describe User, type: :model do

  it "有効なファクトリをもつ" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "ユーザーネーム、メール、パスワードがあればユーザーは有効な状態である" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "ユーザーネームがなければ無効な状態である" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください" )
  end

  it "ユーザーネームが50文字以上であれば無効な状態である" do
    user = FactoryBot.build(:user, username: "a" * 51)
    user.valid?
    expect(user.errors[:username]).to include("は50文字以内で入力してください" )
  end

  it "メールアドレスがなければ無効な状態である" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください" )
  end

  it "メールアドレスが重複していれば無効な状態である" do
    user1 = FactoryBot.create(:user, email: "sample@example.com")
    user2 = FactoryBot.build(:user, email: "sample@example.com")
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します" )
  end

  it "パスワードが空であれば無効な状態である" do
    user = FactoryBot.build(:user, password: " " * 6)
    expect([:password]).to include(:password)
  end

  it "パスワードが5文字以下であれば無効な状態である" do
    user = FactoryBot.build(:user, password: "a" * 5)
    expect([:password]).to include(:password)
  end
end
