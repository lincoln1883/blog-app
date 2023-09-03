class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :text, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :likes_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }

  after_save :increment_posts_counter
  after_destroy :decrement_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_posts_counter
    author.decrement!(:posts_counter)
  end
end
