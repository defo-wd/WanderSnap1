class User < ApplicationRecord
  acts_as_paranoid
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :alive, -> { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end


  def self.ransackable_attributes(auth_object = nil)
  %w[name]
  end


  # アソシエーションもろもろ

   has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy

  has_many :following, through: :active_follows, source: :followee
  has_many :followers, through: :passive_follows, source: :follower

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 通報機能
  has_many :reports, class_name: 'Report', foreign_key: 'reported_post_id', dependent: :destroy
  # レベル、エリア、ポイントのカスタム属性

  # レベルだめかもしれない。間に合わない。
  # attr_accessor :level, :area

  # バリデーションを追加
  # validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :area, presence: false
  # validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  has_one_attached :profile_image

  #ゲストユーザー
 def self.guest
  timestamp = Time.now.to_i

  find_or_create_by!(email: "guest_#{timestamp}@example.com") do |user|
    user.name = "@guest_#{timestamp}"
    user.password = SecureRandom.urlsafe_base64
  end
end



  def increase_points(amount)
    update(points: points + amount)
  end

  def decrease_points(amount)
    update(points: points - amount)
  end

  # カスタム属性へのアクセス方法を定義
  # def level
    # self[:level] || 0 # レベルが nil の場合はデフォルト値 0 を返す
  # end

  # def area
    # self[:area] || "" # エリアが nil の場合は空文字列を返す
  # end

  # ユーザーのレベル、エリア、ポイントを設定
  # def set_user_attributes(level, area, points)
    # update(level: level, area: area, points: points)
  # end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def add_at_to_name
    self.name.prepend("@") unless name&.start_with?("@")
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end



end
