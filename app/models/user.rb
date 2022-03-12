class User < ApplicationRecord


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :movies

  validates :username, :uniqueness => { :case_sensitive => false }
  #has_one_attached :profile_picture, dependent: :destroy
  #validates :profile_picture, content_type: [:png, :jpg, :jpeg]

  rolify

  has_many :posts, through: :roles, source: :resource, source_type: :Post
  has_many :creator_posts, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type: :Post
  has_many :editor_posts, -> { where(roles: {name: :editor}) }, through: :roles, source: :resource, source_type: :Post

  after_create :assign_default_role

  validate :must_have_a_role, on: :update

  private

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least 1 role")
    end
  end


  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?

  end
end
