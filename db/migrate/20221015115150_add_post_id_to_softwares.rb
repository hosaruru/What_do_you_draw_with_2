class AddPostIdToSoftwares < ActiveRecord::Migration[6.1]
  def change
    add_column :softwares, :post_id, :integer
    add_index :softwares, :post_id, unique: true
  end
end
