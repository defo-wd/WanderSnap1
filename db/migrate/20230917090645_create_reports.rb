class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reporter_id
      t.integer :reported_id
      t.integer :reported_post_id
      t.text :description

      t.timestamps
    end
  end
end
