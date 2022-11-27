class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :board_comments, :answer, true
  end

  def down
    change_column_null :board_comments, :answer, false
  end
end
