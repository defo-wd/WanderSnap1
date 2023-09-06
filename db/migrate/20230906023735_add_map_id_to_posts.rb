class AddMapIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :map, null: true, foreign_key: true

  end
end
