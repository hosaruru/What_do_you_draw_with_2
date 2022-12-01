class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :user_id, null: false
      t.string :headline, null: false
      t.text :question, null: false
      t.string :images
      t.timestamps
    end
  end
end
