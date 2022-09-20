class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
          has_many :posts, dependent: :destroy
          has_many :favorites, dependent: :destroy
          has_many :post_comments, dependent: :destroy
   def self.search(search) #self.はUser.を意味する
     if search
       where(['username LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
     else
       all #全て表示させる
    end
 end
end