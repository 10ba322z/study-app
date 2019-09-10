require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user
  describe "#index" do
    it "ユーザーを取得する" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "indexページを取得する" do
      get :index
      expect(response).to have_http_status ("200")
    end
  end

  describe "#show" do
    it "showページを取得する" do
      get :show, params: {id: @user.id}
      expect(response).to have_http_status ("200")
    end
  end

  
end
