class CreatePostMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :post_maps do |t|
      t.references :post, foreign_key: true, null: false
      t.references :map, foreign_key: true, null: false

      t.timestamps
    end
  end
end
