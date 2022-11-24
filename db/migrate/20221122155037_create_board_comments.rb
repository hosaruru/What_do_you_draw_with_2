class CreateBoardComments < ActiveRecord::Migration[6.1]
  def change
    create_table :board_comments do |t|
      t.text :board_comment
      t.integer :user_id
      t.integer :board_id

      t.timestamps
    end
  end
end
