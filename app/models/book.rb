class Book < ApplicationRecord
end
class User < ApplicationRecord
    has_many :books
end

class Post < ApplicationRecord
    belongs_to :user
end