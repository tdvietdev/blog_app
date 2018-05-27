class Entry < ApplicationRecord
  belongs_to :user
  scope :order_by_created_at, ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: {maximum: 300}
end
