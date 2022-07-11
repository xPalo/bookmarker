class ReadingRecord < ApplicationRecord

  belongs_to :user
  belongs_to :book

  enum status: [:plan_to_read, :reading, :read]

end