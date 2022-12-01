class CreateSoftwares < ActiveRecord::Migration[6.1]
  def change
    create_table :softwares do |t|
      t.string :name
      t.integer :post_id
      t.timestamps
    end
  end
end
