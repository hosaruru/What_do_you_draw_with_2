class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      belongs_to :software  # ,optional:true
      has_many :favorites, dependent: :destroy
      has_many :post_comments, dependent: :destroy    
      has_many :tagmaps, dependent: :destroy
      has_many :tags, through: :tagmaps
      has_many :pens, dependent: :destroy
      has_many :notifications, dependent: :destroy
      validates :twitter,:brush, presence: true
      enum status: { published: 0, draft: 1 }
      # allow_destroy: trueをつけることで、子モデルの削除が可能
      accepts_nested_attributes_for :pens, allow_destroy: true
    def favorited?(user)
      favorites.where(user_id: user.id).exists?
    end
    
    # def liked_by?(post_id)
    # favorites.where(post_id: post_id).exists?
    # end
    
     def self.posts_serach(search)
       Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
     end
     
     def pen_present?
        pens.any? do |pen|
          !pen.nil? && pen.use_pen != ""
        end
     end
    ### タグ機能
     def save_posts(tags)
       # フォームから送られてきたタグのうち、すでに存在するタグがひとつでもあった場合は、
       # tagsテーブルのtag_nameカラムからpluckメソッドを使い一旦すべてのデータを引っ張ってきてcurrent_tagsに代入。
       # （すべて新しいものの場合はnilになる）
       current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
       # これから登録するタグの中から、すでに登録済のタグのみをold_tagsに入れる
       old_tags = current_tags - tags
       # これから登録するタグの中から、新規のタグのみをnew_tagsに入れる
       new_tags = tags - current_tags
    
     ## Destroy
       old_tags.each do |old_name|
         self.tags.delete Tag.find_by(tag_name:old_name)
       end
    
     ## Create
       new_tags.each do |new_name|
       #find_or_create_by…条件を指定して初めの1件を取得し1件もなければ作成
         post_tag = Tag.find_or_create_by(tag_name:new_name)
       #<<…配列に1つずつ格納することができる     
         self.tags << post_tag
       end
     end
     
     def clean_tag
        self.tags.each do |tag|
           if Tagmap.where(tag_id:tag.id).where.not(post_id:self.id).count == 0
             tag.destroy
           end  
        end
     end
     def clean_pen
        self.pens.each do |use_pen|
            use_pen.destroy
        end
     end
     
    ### 通知機能
     def create_notification_favorite!(current_user)
     ## いいね
      # すでに「いいね」されているか検索
      # ?は第二引数で取得した値に置き換えることができる
      # whereメソッドでテーブル内の条件に一致したレコードを、配列の形で取得できる
        temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # いいねされていない場合のみ、通知レコードを作成（押した数だけ相手に通知がいってしまうため）
        if temp.blank?
            notification = current_user.active_notifications.new(
                 post_id: id,
                 visited_id: user_id,
                 action: 'favorite'
            )
          # 自分の投稿に対するいいねの場合は、通知済みとする
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
        end
    end
     ## コメント
    def create_notification_post_comment!(current_user, post_comment_id)
       # 自分以外にコメントしている人をすべて取得し、全員に通知を送る。
       # 自分のコメント・重複した場合は除外する
       # selectメソッドで、配列で特定の条件に一致した要素を取得できる
        temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).where.not(user_id: user_id).distinct
        temp_ids.each do |temp_id|
            save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id']) 
        end
       # まだ誰もコメントしていない場合は、投稿者に通知を送る
        save_notification_post_comment!(current_user, post_comment_id, user_id)
    end
    def save_notification_post_comment!(current_user, post_comment_id, visited_id)
       # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
            post_id: id,
            post_comment_id: post_comment_id,
            visited_id: visited_id,
            action: 'post_comment'
            )
      # 自分の投稿に対するコメントの場合は、通知済みとする。
      # 「コメントを登録→通知を登録」の順番のため、たった今登録したコメントの通知レコードが、自分に対して作成されてしまうから。
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
    