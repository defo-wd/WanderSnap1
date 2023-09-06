class User < ApplicationRecord


  # アソシエーションもろもろ
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :follows, source: :followee


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # レベル、エリア、ポイントのカスタム属性
  attr_accessor :level, :area

  # バリデーションを追加
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :area, presence: false
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def increase_points(amount)
    update(points: points + amount)
  end

  def decrease_points(amount)
    update(points: points - amount)
  end

  # カスタム属性へのアクセス方法を定義
  def level
    self[:level] || 0 # レベルが nil の場合はデフォルト値 0 を返す
  end

  def area
    self[:area] || "" # エリアが nil の場合は空文字列を返す
  end

  # ユーザーのレベル、エリア、ポイントを設定
  def set_user_attributes(level, area, points)
    update(level: level, area: area, points: points)
  end

end
