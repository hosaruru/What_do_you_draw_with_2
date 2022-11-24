class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :headline
      t.text :question
      t.text :answer
      t.timestamps
    end
  end
end
