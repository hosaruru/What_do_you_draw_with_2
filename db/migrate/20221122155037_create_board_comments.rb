class CreateBoardComments < ActiveRecord::Migration[6.1]
  def change
    create_table :board_comments do |t|
      t.text :answer, null: false
      t.integer :user_id, null: false
      t.integer :board_id, null: false
      t.string :images, null: false
      t.timestamps
    end
  end
end
