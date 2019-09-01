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
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  mount_uploader :avatar, AvatarUploader

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

# 学習時間を出す
  def daytime
    microposts_day =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_day...Time.zone.today.tomorrow.beginning_of_day)
    start_at_day_sum = microposts_day.pluck('start_at').map!(&:to_i).sum
    end_at_day_sum   = microposts_day.pluck('end_at').map!(&:to_i).sum
    (end_at_day_sum - start_at_day_sum)/60
  end

  def weektime
    microposts_week =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_week...Time.zone.today.next_week.beginning_of_day)
    start_at_week_sum = microposts_week.pluck('start_at').map!(&:to_i).sum
    end_at_week_sum   = microposts_week.pluck('end_at').map!(&:to_i).sum
    (end_at_week_sum - start_at_week_sum)/60
  end

  def monthtime
    microposts_month =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.beginning_of_month...Time.zone.today.next_month.beginning_of_day)
    start_at_month_sum = microposts_month.pluck('start_at').map!(&:to_i).sum
    end_at_month_sum   = microposts_month.pluck('end_at').map!(&:to_i).sum
    (end_at_month_sum - start_at_month_sum)/60
  end

  def daytime_before
    microposts_yesterday =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.yesterday.beginning_of_day...Time.zone.today.beginning_of_day)
    start_at_yesterday_sum = microposts_yesterday.pluck('start_at').map!(&:to_i).sum
    end_at_yesterday_sum   = microposts_yesterday.pluck('end_at').map!(&:to_i).sum
    (end_at_yesterday_sum - start_at_yesterday_sum)/60
  end

  def weektime_before
    microposts_prev_week =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.prev_week.beginning_of_week...Time.zone.today.beginning_of_week)
    start_at_prev_week_sum = microposts_prev_week.pluck('start_at').map!(&:to_i).sum
    end_at_prev_week_sum   = microposts_prev_week.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_week_sum - start_at_prev_week_sum)/60
  end

  def monthtime_before
    microposts_prev_month =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.prev_month.beginning_of_month...Time.zone.today.beginning_of_month)
    start_at_prev_month_sum = microposts_prev_month.pluck('start_at').map!(&:to_i).sum
    end_at_prev_month_sum   = microposts_prev_month.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_month_sum - start_at_prev_month_sum)/60
  end

  def total_studytime
    all_microposts =
    Micropost.where("user_id = :user_id", user_id: id)
    start_at_total = all_microposts.pluck('start_at').map!(&:to_i).sum
    end_at_total   = all_microposts.pluck('end_at').map!(&:to_i).sum
    (end_at_total - start_at_total)/60
  end

# グラフの学習時間を表示させる
  def daytime_before_2days
    microposts_2days_ago =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(2.days).beginning_of_day...Time.zone.yesterday.beginning_of_day)
    start_at_2days_ago_sum = microposts_2days_ago.pluck('start_at').map!(&:to_i).sum
    end_at_2days_ago_sum   = microposts_2days_ago.pluck('end_at').map!(&:to_i).sum
    (end_at_2days_ago_sum - start_at_2days_ago_sum)/60
  end

  def daytime_before_3days
    microposts_3days_ago =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(3.days).beginning_of_day...Time.zone.today.ago(2.days).beginning_of_day)
    start_at_3days_ago_sum = microposts_3days_ago.pluck('start_at').map!(&:to_i).sum
    end_at_3days_ago_sum   = microposts_3days_ago.pluck('end_at').map!(&:to_i).sum
    (end_at_3days_ago_sum - start_at_3days_ago_sum)/60
  end

  def daytime_before_4days
    microposts_4days_ago =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(4.days).beginning_of_day...Time.zone.today.ago(3.days).beginning_of_day)
    start_at_4days_ago_sum = microposts_4days_ago.pluck('start_at').map!(&:to_i).sum
    end_at_4days_ago_sum   = microposts_4days_ago.pluck('end_at').map!(&:to_i).sum
    (end_at_4days_ago_sum - start_at_4days_ago_sum)/60
  end

  def weektime_before_2weeks
    microposts_prev_2weeks =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(2.weeks).beginning_of_week...Time.zone.today.prev_week.beginning_of_week)
    start_at_prev_2weeks_sum = microposts_prev_2weeks.pluck('start_at').map!(&:to_i).sum
    end_at_prev_2weeks_sum   = microposts_prev_2weeks.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_2weeks_sum - start_at_prev_2weeks_sum)/60
  end

  def weektime_before_3weeks
    microposts_prev_3weeks =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(3.weeks).beginning_of_week...Time.zone.today.ago(2.weeks).beginning_of_week)
    start_at_prev_3weeks_sum = microposts_prev_3weeks.pluck('start_at').map!(&:to_i).sum
    end_at_prev_3weeks_sum   = microposts_prev_3weeks.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_3weeks_sum - start_at_prev_3weeks_sum)/60
  end

  def weektime_before_4weeks
    microposts_prev_4weeks =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(4.weeks).beginning_of_week...Time.zone.today.ago(3.weeks).beginning_of_week)
    start_at_prev_4weeks_sum = microposts_prev_4weeks.pluck('start_at').map!(&:to_i).sum
    end_at_prev_4weeks_sum   = microposts_prev_4weeks.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_4weeks_sum - start_at_prev_4weeks_sum)/60
  end

  def monthtime_before_2months
    microposts_prev_2months =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(2.months).beginning_of_month...Time.zone.today.prev_month.beginning_of_month)
    start_at_prev_2months_sum = microposts_prev_2months.pluck('start_at').map!(&:to_i).sum
    end_at_prev_2months_sum   = microposts_prev_2months.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_2months_sum - start_at_prev_2months_sum)/60
  end

  def monthtime_before_3months
    microposts_prev_3months =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(3.months).beginning_of_month...Time.zone.today.ago(2.months).beginning_of_month)
    start_at_prev_3months_sum = microposts_prev_3months.pluck('start_at').map!(&:to_i).sum
    end_at_prev_3months_sum   = microposts_prev_3months.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_3months_sum - start_at_prev_3months_sum)/60
  end

  def monthtime_before_4months
    microposts_prev_4months =
    Micropost.where("user_id = :user_id", user_id: id)
    .where(created_at: Time.zone.today.ago(4.months).beginning_of_month...Time.zone.today.ago(3.months).beginning_of_month)
    start_at_prev_4months_sum = microposts_prev_4months.pluck('start_at').map!(&:to_i).sum
    end_at_prev_4months_sum   = microposts_prev_4months.pluck('end_at').map!(&:to_i).sum
    (end_at_prev_4months_sum - start_at_prev_4months_sum)/60
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
