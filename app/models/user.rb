class User < ApplicationRecord
  attachment :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
    has_many :books
end

class Post < ApplicationRecord
    belongs_to :user
end