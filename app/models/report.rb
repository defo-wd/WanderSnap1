class Report < ApplicationRecord
  belongs_to :reporter, class_name: 'User', foreign_key: 'reporter_id'
  belongs_to :reported, class_name: 'User', foreign_key: 'reported_id'
  belongs_to :reported_post, class_name: 'Post', foreign_key: 'reported_post_id'
  validates :reason, presence: true

  enum status: { waiting: 0, keep: 1, finish: 2 }

end
