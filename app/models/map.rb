class Map < ApplicationRecord
  mount_uploader :photo_url, PostSnapUploader
  has_many :post_maps
  belongs_to :posts
  belongs_to :post
  # Geocoderで緯度経度から住所を取得
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :latitude, :longitude, presence: true
  validates :spot_name, :description, presence: true

end