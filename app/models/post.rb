class Post < ApplicationRecord
  acts_as_paranoid
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :alive, -> { where(deleted_at: nil) }

  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  belongs_to :user
  has_many :post_maps, dependent: :destroy
  has_many :maps, through: :post_maps
  has_many :reports, class_name: 'Report', foreign_key: 'reported_post_id'

  validates :body, presence: true
  validates :snap, presence: true

  mount_uploader :snap, PostSnapUploader # CarrierWave

  def liked_by?(user)
  likes.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(body) + _ransackers.keys
  end

end
