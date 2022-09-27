class AddTagNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tag_name, :string
  end
end
