class Map < ApplicationRecord
  mount_uploader :photo_url, PostSnapUploader
  has_many :post_maps, dependent: :destroy
  # Geocoderで緯度経度から住所を取得
  #  geocoded_by :spot_name
   # after_validation :geocode
  #validates :latitude, :longitude, presence: true
  validates :spot_name,  presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w(spot_name) + _ransackers.keys
  end


end
