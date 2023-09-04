class AddLevelAndAreaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :level, :integer
    add_column :users, :area, :string
  end
end
