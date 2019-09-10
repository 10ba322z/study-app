require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    token = @user.confirmation_token
    visit user_confirmation_path(confirmation_token: token)
    expect(page).to have_content "アカウントの確認が成功しました。"
    visit root_path
    fill_in "user_email",    with: @user.email
    fill_in "user_password", with: @user.password
    click_button "ログイン"
    expect(page).to have_content "ログインしました"
  end

  scenario "新しいマイクロポストを作成する" do
    expect {
      fill_in "micropost_start_at", with: Time.zone.now - 2.hour
      fill_in "micropost_end_at",   with: Time.zone.now
      fill_in "micropost_content",  with: "feature spec test"
      click_button "学習時間を記録"

      expect(page).to have_content "学習時間を記録しました"
      expect(page).to have_content "feature spec test"
      expect(page).to have_content "120 分学習しました"
    }.to change(@user.microposts, :count).by(1)
  end
end
