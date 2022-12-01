class Board < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :board_comments, dependent: :destroy
    has_many :board_comment_users, through: :board_comments, source: :user
    has_many :notifications, dependent: :destroy
    validates :headline,:question, presence: true
    def get_image
        if image.attached?
            image
        end   
    end
end
