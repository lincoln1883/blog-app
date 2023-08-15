class ChangeCommentsCounter < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :commentsCounter, :comments_counter
  end
end
