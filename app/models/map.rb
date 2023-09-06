class Map < ApplicationRecord
  has_many :posts
  # Geocoderで緯度経度から住所を取得
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  validates :latitude, :longitude, presence: true
  validates :spot_name, :description, presence: true

end