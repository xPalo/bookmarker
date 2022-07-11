class ReadingRecord < ApplicationRecord

  belongs_to :user
  belongs_to :book

  enum status: [:plan_to_read, :reading, :read]

  validates :user_id, presence: true
  validates :book_id, presence: true

end