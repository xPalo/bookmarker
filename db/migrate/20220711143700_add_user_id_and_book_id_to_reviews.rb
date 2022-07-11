class AddUserIdAndBookIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :user
    add_reference :reviews, :book
  end
end
