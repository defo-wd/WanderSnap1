class CreatePostMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :post_maps do |t|
      t.references :post, null: false, foreign_key: true
      t.references :map, null: false, foreign_key: true

      t.timestamps
    end
  end
end
