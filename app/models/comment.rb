class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  validates :body, presence: true


  def depth
    parent ? parent.depth + 1 : 0
  end


end
