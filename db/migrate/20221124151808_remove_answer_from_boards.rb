class RemoveAnswerFromBoards < ActiveRecord::Migration[6.1]
  def change
    remove_column :boards, :answer, :text
  end
end
