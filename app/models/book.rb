class Book < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  belongs_to :author

  validates :title, presence: true
  validates :title_sk, presence: true
  validates :isbn, presence: true

  def rating
    if self.reviews.length > 0
      sum = 0
      self.reviews.each { |r| sum += r.score }
      (sum/self.reviews.length)*10
    else
      nil
    end
  end
end