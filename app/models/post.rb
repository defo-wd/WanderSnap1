# app/models/post.rb
class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :user
  belongs_to :map
  mount_uploader :snap, PostSnapUploader # CarrierWaveを使用する場合

  validates :body, presence: true
  validates :snap, presence: true # 画像が必須の場合
end
