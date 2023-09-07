class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :maps
  accepts_nested_attributes_for :maps, allow_destroy: true, reject_if: :all_blank
  has_one :map
  accepts_nested_attributes_for :map, allow_destroy: true, reject_if: :all_blank
  belongs_to :user

  validates :body, presence: true
  validates :snap, presence: true

  mount_uploader :snap, PostSnapUploader # CarrierWave
end
