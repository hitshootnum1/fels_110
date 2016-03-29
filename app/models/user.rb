class User < ActiveRecord::Base

  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :activities
  has_many :lessons

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 150},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  after_create :add_avatar
  before_save :downcase_email
  has_secure_password

  private
  def downcase_email
    self.email = email.downcase
  end
end
