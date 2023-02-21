class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
          has_one_attached :image_local
          has_many :posts, dependent: :destroy
          has_many :favorites, dependent: :destroy
          has_many :post_comments, dependent: :destroy
          has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
          has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
          has_many :boards, dependent: :destroy
          has_many :board_comments, dependent: :destroy
          
          # フォローをした、されたの関係
          has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
          has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
          
          # 一覧画面で使う
          has_many :followings, through: :relationships, source: :followed
          has_many :followers, through: :reverse_of_relationships, source: :follower
          
          validates :user_name, presence: true
          
  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する
  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    user ||= User.create!(
      uid: auth.uid,
      provider: auth.provider,
      user_name: auth[:info][:name],
      image: auth[:info][:image],
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )
    user
  end
  # ダミーのメールアドレスを作成
  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end
  def liked_by?(post_id)
    favorites.where(post_id: post_id).exists?
  end
  
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end