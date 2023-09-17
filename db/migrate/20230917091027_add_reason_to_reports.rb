class AddReasonToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :reason, :text
  end
end
