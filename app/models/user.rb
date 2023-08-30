class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  validates :name, presence: true, length: { minimum: 3 }
  validates :posts_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true, length: { minimum: 5, maximum: 500 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
