class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  validates_presence_of :text, presence: true, length: { minimum: 3, maximum: 250 }
  after_create :increment_comments_counter

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
