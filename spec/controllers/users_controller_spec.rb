require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user
  describe "#index" do
    it "現在のユーザーを取得する" do
      #下のテストは書き直す
      expect(subject.current_user).to_not eq(nil)
    end

    it "インデックスページを取得する" do
      get :index
      expect(response).to have_http_status ("200")
    end
  end
  describe "#show" do
    
  end
end
