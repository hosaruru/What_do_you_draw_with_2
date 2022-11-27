class ChangeCloumnsNotnullAddBoard < ActiveRecord::Migration[6.1]
  def change
    change_column_null :boards, :question, false
  end
end
