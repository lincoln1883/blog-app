class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  validates :name, presence: true, length: { minimum: 3 }
  validates :posts_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true, length: { minimum: 5, maximum: 500 }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
