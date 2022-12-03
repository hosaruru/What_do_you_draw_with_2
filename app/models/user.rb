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

end