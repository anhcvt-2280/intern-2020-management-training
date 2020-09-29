class Comment < ApplicationRecord
  COMMENT_PARAM_PERMIT = :content

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  scope :order_by_created_at, ->{order created_at: :desc}
end
