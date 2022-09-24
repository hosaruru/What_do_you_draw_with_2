class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      has_many :favorites, dependent: :destroy
      has_many :post_comments, dependent: :destroy    
      has_many :tagmaps, dependent: :destroy
      has_many :tags, through: :tagmaps
    def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
    enum twitter: { youtube: 0, twitter: 1 }

end
