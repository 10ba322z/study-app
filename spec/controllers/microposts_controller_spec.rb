require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  login_user
  describe "#create" do
    context "有効な内容を持つとき" do
      it "マイクロポストを投稿できる" do
        micropost_params = FactoryBot.attributes_for(:micropost)
        expect {post :create, params: {micropost: micropost_params}}.to change(@user.microposts, :count).by(1)
      end
    end
    context "無効な内容を持つとき" do
      it "マイクロポストを投稿できない" do
        micropost_params = FactoryBot.attributes_for(:micropost, :invalid)
        expect {post :create, params: {micropost: micropost_params}}.to_not change(@user.microposts, :count)
      end
    end
  end

  describe "#delete" do
    context "有効なユーザーの場合" do
      it "マイクロポストを削除できる" do
        micropost = FactoryBot.create(:micropost, user_id: @user.id)
        expect {delete :destroy, params: {id: micropost.id}}.to change(@user.microposts, :count).by(-1)
      end
    end
    context "無効なユーザーの場合" do
      it "マイクロポストを削除できない" do
        other_user = FactoryBot.create(:user)
        micropost = FactoryBot.create(:micropost, user_id: other_user.id)
        expect {delete :destroy, params: {id: micropost.id}}.to_not change(other_user.microposts, :count)
      end
    end
  end
end
