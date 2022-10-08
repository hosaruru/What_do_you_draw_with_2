class CreateEmbeds < ActiveRecord::Migration[6.1]
  def change
    create_table :embeds do |t|

      t.timestamps
    end
  end
end
