class AddTagIdToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :tag_id, :integer
  end
end
