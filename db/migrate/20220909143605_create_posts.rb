class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :tag
      t.integer :software_id
      t.string :brush
      t.text :comments
      t.string :images
      t.text :introduction
      t.string :tag_name
      t.string :name
      t.text :twitter
      t.timestamps
    end
  end
end
