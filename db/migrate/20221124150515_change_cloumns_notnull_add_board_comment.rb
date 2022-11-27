class ChangeCloumnsNotnullAddBoardComment < ActiveRecord::Migration[6.1]
  def change
    change_column_null :board_comments, :board_comment, false
  end
end
