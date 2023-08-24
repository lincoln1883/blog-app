class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post', foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  private

  def increment_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end
end
