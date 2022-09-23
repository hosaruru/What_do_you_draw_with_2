class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      has_many :favorites, dependent: :destroy
      has_many :post_comments, dependent: :destroy    
    def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
    enum twitter: { youtube: 0, twitter: 1 }

  validates :identifier, length: { maximum: 200 }
end
