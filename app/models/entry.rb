class Entry < ApplicationRecord
  belongs_to :user
  scope :order_by_created_at, ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: {maximum: 300}


  scope :by_followed, (lambda do |user_id|
    where("user_id IN (SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id)
      OR user_id = :user_id", user_id: user_id).order created_at: :desc
  end)
end
