class RemoveSoftwareToPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :software, :string
  end
end
