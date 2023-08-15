class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes


  after_save :update_counters, if: :saved_change_to_id?
  after_create :increment_posts_counter
  after_destroy :decrement_posts_counter

  def update_counters
    update(comments_counter: comments.count, likes_counter: likes.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def decrement_posts_counter
    author.decrement(:posts_counter)
    author.save
  end

  def increment_posts_counter
    author.increment(:posts_counter)
    author.save
  end
end
