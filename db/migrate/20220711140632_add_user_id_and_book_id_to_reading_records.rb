class AddUserIdAndBookIdToReadingRecords < ActiveRecord::Migration[7.0]
  def change
    add_reference :reading_records, :user
    add_reference :reading_records, :book
  end
end
