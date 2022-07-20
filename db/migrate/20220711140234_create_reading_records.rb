class CreateReadingRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_records do |t|
      t.timestamp :finished_reading_at

      t.timestamps
    end
  end
end