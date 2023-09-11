class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user

  validates :body, presence: true
  validates :snap, presence: true

  mount_uploader :snap, PostSnapUploader # CarrierWave
end
