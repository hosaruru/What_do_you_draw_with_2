class AddSoftwareIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :software_id, :integer
  end
end
