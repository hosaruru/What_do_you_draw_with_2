class Post < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      belongs_to :software
      has_many :favorites, dependent: :destroy
      has_many :post_comments, dependent: :destroy    
      has_many :tagmaps, dependent: :destroy
      has_many :tags, through: :tagmaps
      has_many :pens, dependent: :destroy
      has_many :notifications, dependent: :destroy
      validates :twitter,:brush, presence: true
      accepts_nested_attributes_for :pens, allow_destroy: true
    def favorited?(user)
      favorites.where(user_id: user.id).exists?
    end
     def self.posts_serach(search)
       Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
     end
     
     def pen_present?
        pens.any? do |pen|
          !pen.nil? && pen.use_pen != ""
        end
     end
    
     def save_posts(tags)
       # フォームから送られてきたタグのうち、すでに存在するタグがひとつでもあった場合は、
       # tagsテーブルのtag_nameカラムからpluckメソッドを使い一旦すべてのデータを引っ張ってきてcurrent_tagsに代入
       current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
       # これから登録するタグの中から、すでに登録済のタグのみをold_tagsに入れる
       old_tags = current_tags - tags
       # これから登録するタグの中から、新規のタグのみをold_tagsに入れる
       new_tags = tags - current_tags
    
       # Destroy
    #   old_tags.each do |old_name|
    #      tag= Tag.find_by(tag_name:old_name)
    #      self.tags.delete tag
    #      if Tagmap.where(tag_id:tag.id).count == 0
    #       tag.destroy
    #      end
    #   end
    
    #   # Create
    #   new_tags.each do |new_name|
    #      post_tag = Tag.find_or_create_by(tag_name:new_name)
    #      self.tags << post_tag
    #   end
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
     def create_notification_favorite!(current_user)
         temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
        if temp.blank?
             notification = current_user.active_notifications.new(
                 post_id: id,
                 visited_id: user_id,
                 action: 'favorite'
            )
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
        end
    end
    def create_notification_post_comment!(current_user, post_comment_id)
        # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).where.not(user_id: user_id).distinct#コメントに基づいている、ユーザーIDを取得・・？
        temp_ids.each do |temp_id|
            save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id']) 
        end
        save_notification_post_comment!(current_user, post_comment_id, user_id) 
    end
    def save_notification_post_comment!(current_user, post_comment_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            post_comment_id: post_comment_id,
            visited_id: visited_id,
            action: 'post_comment'
            )
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
    
