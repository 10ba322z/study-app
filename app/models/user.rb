class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :username, presence: true
  mount_uploader :avatar, AvatarUploader

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def daytime
    microposts_day =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_day...Time.zone.today.end_of_day)
    start_at_day_sum = microposts_day.pluck('start_at').map!(&:to_i).sum
    end_at_day_sum   = microposts_day.pluck('end_at').map!(&:to_i).sum
    (end_at_day_sum - start_at_day_sum)/60
  end

  def weektime
    microposts_week =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_week...Time.zone.today.end_of_week)
    start_at_week_sum = microposts_week.pluck('start_at').map!(&:to_i).sum
    end_at_week_sum   = microposts_week.pluck('end_at').map!(&:to_i).sum
    (end_at_week_sum - start_at_week_sum)/60
  end

  def monthtime
    microposts_month =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_month...Time.zone.today.end_of_month)
    start_at_month_sum = microposts_month.pluck('start_at').map!(&:to_i).sum
    end_at_month_sum   = microposts_month.pluck('end_at').map!(&:to_i).sum
    (end_at_month_sum - start_at_month_sum)/60
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
