class User < ApplicationRecord
  attachment :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
    has_many :books, dependent: :destroy
    attachment :profile_image
end

class Post < ApplicationRecord
    belongs_to :user
end