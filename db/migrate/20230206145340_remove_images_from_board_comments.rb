class RemoveImagesFromBoardComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :board_comments, :images, :string
  end
end
