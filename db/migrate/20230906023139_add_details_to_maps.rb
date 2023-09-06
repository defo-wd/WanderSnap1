class AddDetailsToMaps < ActiveRecord::Migration[6.1]
  def change
    add_column :maps, :spot_name, :string
    add_column :maps, :description, :text
    add_column :maps, :photo_url, :string
  end
end
