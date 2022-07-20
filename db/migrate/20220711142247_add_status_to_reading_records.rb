class AddStatusToReadingRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :reading_records, :status, :integer
  end
end