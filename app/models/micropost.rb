class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content,  length: { maximum: 255 }
  validates :start_at, presence: true
  validates :end_at,   presence: true
  validate  :start_at_should_be_before_end_at
  validate  :studing_time_should_not_overlap
  validate  :picture_size

private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def start_at_should_be_before_end_at
    return unless start_at && end_at
    if start_at >= end_at
      errors.add(:start_at, 'は終了時間よりも前に設定してください')
    end
  end

  def studing_time_should_not_overlap
    return unless start_at && end_at
    if Micropost
           .where("user_id = :user_id", user_id: id)
           .where("start_at < ?", end_at)
           .where("end_at > ?", start_at)
           .where.not(id: id).exists?
      errors.add(:base, '他の学習時間と重複しています')
    end
  end
end
