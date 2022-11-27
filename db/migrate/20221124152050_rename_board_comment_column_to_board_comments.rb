class RenameBoardCommentColumnToBoardComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :board_comments, :board_comment, :answer
  end
end
