# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :snap, PostSnapUploader # CarrierWaveを使用する場合

  validates :body, presence: true
  validates :snap, presence: true # 画像が必須の場合
end
