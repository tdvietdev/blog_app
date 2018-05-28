class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  belongs_to :parent,  class_name: "Comment", optional: true
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  scope :root_comment, ->{where(parent_id: nil)}
  def parent?
    self.parent.nil?
  end

  def new_reply
    self.replies.build(entry_id: self.entry_id)
  end
end
