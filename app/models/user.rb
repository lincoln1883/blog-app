class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  validates :name, presence: true, length: { minimum: 3 }
  validates :posts_counter, numericality: { integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true, length: { minimum: 5, maximum: 500 }

  before_create :set_default_photo
  before_create :set_default_role

  ROLES = %i[admin user].freeze

  def admin?
    role == 'admin'
  end

  def set_default_photo
    self.photo ||= "https://randomuser.me/api/portraits/men/#{rand(1..100)}.jpg"
  end

  def set_default_role
    self.role ||= 'user'
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
