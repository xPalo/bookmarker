class ReadingRecord < ApplicationRecord

  belongs_to :user
  belongs_to :book

  enum status: [:plan_to_read, :reading, :read]

  validates :user_id, presence: true
  validates :book_id, presence: true
  # validate  :only_unique_records
  #
  # def only_unique_records
  #   errors.add("You already keep track of this book") if
  # end

end