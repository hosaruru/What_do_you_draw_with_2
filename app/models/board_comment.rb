class BoardComment < ApplicationRecord
    belongs_to :user
    belongs_to :board
    validates :answer, presence: true
    
    def create_notification_board_comment!
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      board_comment_users = board.board_comment_users.where.not(id: user.id).where.not(id: board.user_id).select(:id).distinct #コメントに基づいている、ユーザーIDを取得・・？
      board_comment_users.each do |board_comment_user|
        save_notification_board_comment!(board_comment_user.id)
      end
      save_notification_board_comment!
    end
    
    def save_notification_board_comment!(visited_id = board.user_id)
      notification = Notification.new(
        board_comment_id: id,
        visitor_id: user_id,
        visited_id: visited_id,
        action: 'board_comment')
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save!
    end
end
