class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :tag
      t.string :software
      t.string :brush
      t.text :comments
      t.string :images
      
      t.timestamps
    end
  end
end
