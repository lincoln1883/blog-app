class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :text, presence: true, length: { minimum: 5, maximum: 250 }
  validates :likes_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }

  after_create :increment_posts_counter

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def increment_posts_counter
    author.increment(:posts_counter)
  end
end
