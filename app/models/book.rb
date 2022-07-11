class Book < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  belongs_to :author

  validates :title, presence: true
  validates :title_sk, presence: true
  validates :isbn, presence: true

end
