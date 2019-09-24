require 'rails_helper'

RSpec.feature "Users", type: :feature do
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

  scenario "ログアウトするとメッセージが表示される" do
    click_link "ログアウト"
    expect(page).to have_content "ログアウトしました。"
  end

  scenario "学習時間のリンクを押すと詳細画面へ遷移する" do
    click_link "学習時間"
    expect(page).to have_content "学習時間グラフ"
  end

  context "フォロー、フォロワーのページが表示される" do
    scenario "フォローのページが表示される" do
      page.find("#following.stat").click
      expect(page).to have_content "フォロー"
    end
    scenario "フォロワーのページが表示される" do
      page.find("#followers.stat").click
      expect(page).to have_content "フォロワー"
    end
  end

  context "各ページのタイトルが表示される" do
    scenario "トップページのタイトルが表示される" do
      expect(page).to have_title "Study App"
    end
    scenario "詳細ページのタイトルが表示される" do
      visit user_path(@user.id)
      expect(page).to have_title "学習データ | Study App"
    end
    scenario "フォローページのタイトルが表示される" do
      visit following_user_path(@user.id)
      expect(page).to have_title "フォロー | Study App"
    end
    scenario "フォロワーページのタイトルが表示される" do
      visit followers_user_path(@user.id)
      expect(page).to have_title "フォロワー | Study App"
    end
  end

  scenario "プロフィール変更ページで変更ができる" do
    visit edit_user_registration_path(@user.id)
    fill_in "user_username", with: "update_name"
    click_button "情報の更新"
    expect(page).to have_content "アカウントが更新されました。"
  end
end
