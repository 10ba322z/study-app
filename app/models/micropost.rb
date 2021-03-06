class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # rubocop:disable Airbnb/DefaultScope
  mount_uploader :picture, PictureUploader
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  validates :user_id, presence: true
  validates :content,  length: { maximum: 255 }
  validates :start_at, presence: true
  validates :end_at,   presence: true
  validate  :start_at_should_be_before_end_at
  validate  :studing_time_should_not_overlap
  validate  :picture_size

  def iine(user)
    likes.create(user_id: user.id)
  end

  def deleteiine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB以下にしてください")
    end
  end

  def start_at_should_be_before_end_at
    return unless start_at && end_at # rubocop:disable Airbnb/SimpleModifierConditional,Airbnb/SimpleUnless
    if start_at >= end_at
      errors.add(:start_at, 'は終了時間よりも前に設定してください')
    end
  end

  def studing_time_should_not_overlap
    if Micropost.
        where(user_id: user_id).
        where("start_at < ?", end_at).
        where("end_at > ?", start_at).
        where.not(id: id).exists?
      errors.add(:base, '他の学習時間と重複しています')
    end
  end
end
