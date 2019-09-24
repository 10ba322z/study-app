require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user)      {FactoryBot.create(:user)}
  let(:micropost) {FactoryBot.create(:micropost)}
  let(:like)      {FactoryBot.create(:like, user_id: user.id, micropost_id: micropost.id)}

  login_user
  describe "#create" do
    it "Ajexが反応する" do
      post :create, format: :js, params: { micropost_id: micropost.id, user_id: user.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    it "add a new like" do
      expect {post :create, format: :js, params: { micropost_id: micropost.id, user_id: user.id } }.to change{ Like.count }.by(1)
    end
  end
  describe "#delete" do
    it "Ajexが反応する" do
      delete :destroy, format: :js, params: { micropost_id: micropost.id, user_id: user.id, id: like.id }
      expect(response.content_type).to eq "text/javascript"
    end
    it "remove a like" do
      like = FactoryBot.create(:like, user_id: @user.id, micropost_id: micropost.id)
      expect {delete :destroy, format: :js, params: { user_id: @user.id, micropost_id: micropost.id, id: like.id } }.to change{ Like.count }.by(-1)
    end
  end
end
