class CreateSoftwares < ActiveRecord::Migration[6.1]
  def change
    create_table :softwares do |t|
     t.string :software
      t.timestamps
    end
  end
end
