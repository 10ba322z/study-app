require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザーネーム、メール、パスワードがあればユーザーは有効な状態である" do
    user = User.create(
      username: "aiueo",
      email:    "tester@example.com",
      password: "tester",
    )
    expect(user).to be_valid
  end

  it "ユーザーネームがなければ無効な状態である" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください" )
  end
end
