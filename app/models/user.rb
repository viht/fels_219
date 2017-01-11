class User < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :questions
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {email.downcase!}

  enum role: {user: Settings.user, admin: Settings.admin}

  validates :name, presence: true, length: {maximum: Settings.size_content}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true,
   length: {minimum: Settings.size_password}, allow_nil: true

  scope :recent, -> {order created_at: :desc}

  mount_uploader :avatar, AvatarUploader

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    follow_users = active_relationships.find_by(followed_id: other_user.id)
    if follow_users
      follow_users.destroy
    else
      false
    end
  end

  def following? other_user
    following.include? other_user
  end
end
