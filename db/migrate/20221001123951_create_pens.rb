class CreatePens < ActiveRecord::Migration[6.1]
  def change
    create_table :pens do |t|
      t.references :post, null: false, foreign_key: true
      t.string :ing_name
      t.string :quantity
      t.string :use_pen

      t.timestamps
    end
  end
end
