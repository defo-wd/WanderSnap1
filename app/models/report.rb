class Report < ApplicationRecord
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :reported, class_name: 'User', foreign_key: 'reported_id', optional: true
  belongs_to :reported_post, class_name: 'Post', foreign_key: 'reported_post_id', optional: true

  validates :reason, presence: true
  validate :either_reported_or_reported_post_present

  enum status: { waiting: 0, keep: 1, finish: 2 }

  private

  def either_reported_or_reported_post_present
    if reported_id.blank? && reported_post_id.blank?
      errors.add(:base, "報告されたユーザーまたは投稿のいずれかが存在しなければなりません")
    end
  end
end
