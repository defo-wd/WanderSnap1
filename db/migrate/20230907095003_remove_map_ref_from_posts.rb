class RemoveMapRefFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :posts, :map, null: false, foreign_key: true
  end
end
