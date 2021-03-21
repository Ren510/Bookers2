class User < ApplicationRecord
has_many :books, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  attachment :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
