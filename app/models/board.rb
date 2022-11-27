class Board < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :board_comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    validates :headline,:question, presence: true
    def get_image
        if image.attached?
            image
        end   
    end
     def create_notification_favorite!(current_user)
         temp = Notification.where(["visitor_id = ? and visited_id = ? and board_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
        if temp.blank?
             notification = current_user.active_notifications.new(
                 board_id: id,
                 visited_id: user_id,
                 action: 'favorite'
            )
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
        end
    end
    def create_notification_board_comment!(current_user, board_comment_id)
        # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
        temp_ids = BoardComment.select(:user_id).where(board_id: id).where.not(user_id: current_user.id).distinct#コメントに基づいている、ユーザーIDを取得・・？
        temp_ids.each do |temp_id|
            save_notification_board_comment!(current_user, board_comment_id, temp_id['user_id']) 
            
        end
         save_notification_board_comment!(current_user, board_comment_id, user_id) 
    end
    def save_notification_board_comment!(current_user, board_comment_id, visited_id)
        notification = current_user.active_notifications.new(
            board_id: id,
            comment_id: board_comment_id,
            visited_id: visited_id,
            action: 'board_comment'
            )
        if notification.visiter_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
