class AddIntroductionToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :introduction, :text
  end
end
