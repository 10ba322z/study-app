class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :microposts, dependent: :destroy

  def feed
    Micropost.where("user_id = ?", id)
  end
end
