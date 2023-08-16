class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  validates :name, presence: true, length: { minimum: 5 }
  validates :posts_counter, type: Integer, comparison: { greater_than_or_equal_to: 0 }

  after_commit :update_posts_counter, if: :saved_change_to_id?

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  private

  def update_posts_counter
    update(posts_counter: posts.count) unless posts.empty?
  end
end
