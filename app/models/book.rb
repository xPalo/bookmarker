class Book < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  belongs_to :author

end
