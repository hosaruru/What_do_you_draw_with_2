class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      has_many :favorites, dependent: :destroy
    
    def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
end
