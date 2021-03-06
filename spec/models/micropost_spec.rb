require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @micropost = @user.microposts.create(
      content: "test content",
      start_at: Time.zone.now,
      end_at:   Time.zone.now + 2.hour
    )
  end

  it "マイクロポストにstart_atとend_atがあれば有効である" do
    expect(@micropost).to be_valid
  end

  it "contentが255文字以上あれば無効である" do
    @micropost.content = "a" * 256
    expect(@micropost).to_not be_valid
  end

  it "start_atがend_atより後ならば無効である" do
    @micropost.start_at = Time.zone.now + 3.hour
    expect(@micropost).to_not be_valid
  end

  it "学習時間に重複があれば無効である" do
    micropost_overlap = @user.microposts.create(
      content: "test content2",
      start_at: Time.zone.now - 1.hour,
      end_at:   Time.zone.now + 3.hour,
    )
    expect(micropost_overlap).to_not be_valid
  end
end
