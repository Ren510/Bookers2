class User < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :favorites
  has_many :favorite_books, through: :favorites, source: :book #throughでbookとuserをつないでます
  has_many :book_comments, dependent: :destroy

  def self.search(search,word)
    if search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @user = User.where(name: word)
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships,class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followeds, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    unless self == other_user
      # self.active_relationships.find_or_create_by(follow_id: other_user.id)
      relationship = Relationship.new(follower_id: self.id , followed_id: other_user.id)
      relationship.save!
    end
  end

  def unfollow(other_user)
    relationship = self.active_relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
    # relationship = self.relationships.find_by(followed_id: self.id , follower_id:  other_user.id)
    # relationship = Relationship.findd_by(follower_id: xxx, followed_id: xxx)
    # relationship.destroy if relationship
  end

  def following?(other_user)
    # self.followers.include?(other_user)
    self.followeds.include?(other_user)
  end

  attachment :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
  uniqueness: true,
            length: { minimum: 2,maximum: 20 }

  validates :introduction,
            length: { maximum: 50 }

end
