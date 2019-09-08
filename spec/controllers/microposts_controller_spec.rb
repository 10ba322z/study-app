require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  login_user

  describe "#create" do
    it "マイクロポストを投稿できる" do
      micropost_params = FactoryBot.attributes_for(:micropost)
      expect {post :create, params: {micropost: micropost_params}}.to change(@user.microposts, :count).by(1)
    end
  end

  describe "#delete" do
    it "マイクロポストを削除できる" do
      micropost = FactoryBot.create(:micropost, user_id: @user.id)
      expect {delete :destroy, params: {id: micropost.id}}.to change(@user.microposts, :count).by(-1)
    end
  end
end
