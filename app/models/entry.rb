class Entry < ApplicationRecord
  belongs_to :user
  scope :order_by_created_at, ->{where(active: true).order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: {maximum: Settings.entry.title.max_length}
  has_many :comments
  has_many :likes
  has_many :liked, through: :likes, source: :user

  def same_author
    user.entries.order_by_created_at.limit 5
  end

  class << self
    def most_present
      arr = Like.select("entry_id, COUNT(id) as total_like").group(:entry_id).order("total_like desc").
        limit Settings.entry.most_present.max_length
      return arr.map{|a| Entry.find_by id: a.entry_id} if arr
    end

    def draft user
      where active: false, user_id: user.id
    end

    def actived user
      where active: true, user_id: user.id
    end
    if Rails.env.production?
      def search search
        if search
          where("active = true AND (title LIKE ? OR description LIKE ?)", "%#{search}%", "%#{search}%")
        else
          all
        end
      end
    else
      def search search
        if search
          where("active = 1 AND (title LIKE ? OR description LIKE ?)", "%#{search}%", "%#{search}%")
        else
          all
        end
      end
    end
  end


  if Rails.env.production?
    scope :by_followed, (lambda do |user_id|
      where("active = true AND (user_id IN (SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id)
      OR user_id = :user_id)", user_id: user_id).order created_at: :desc
    end)
  else
    scope :by_followed, (lambda do |user_id|
      where("active = 1 AND (user_id IN (SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id)
      OR user_id = :user_id)", user_id: user_id).order created_at: :desc
    end)
  end

end
