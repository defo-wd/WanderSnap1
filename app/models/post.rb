class Post < ApplicationRecord
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  belongs_to :user
  has_many :post_maps, dependent: :destroy
  has_many :maps, through: :post_maps

  validates :body, presence: true
  validates :snap, presence: true

  mount_uploader :snap, PostSnapUploader # CarrierWave

  def liked_by?(user)
  likes.where(user_id: user.id).exists?
  end
end
