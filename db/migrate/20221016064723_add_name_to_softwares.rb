class AddNameToSoftwares < ActiveRecord::Migration[6.1]
  def change
    rename_column :softwares, :software, :name
  end
end
