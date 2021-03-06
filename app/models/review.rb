class Review < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :score, presence: true

end
