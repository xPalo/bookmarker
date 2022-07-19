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

  def comparison_rating
    if self.reviews.length > 0
      sum = 0
      self.reviews.each { |r| sum += r.score }
      (sum/self.reviews.length)*10
    else
      -1
    end
  end

  def comparison_ratings
    if self.reviews.length > 0
      reviews.length
    else
      0
    end
  end

  def ratings
    if self.reviews.length > 0
      reviews.length
    else
      nil
    end
  end

  def self.search(search)
    if search
      Book.joins(:author).where("lower(title || title_sk || CONCAT_WS(' ', first_name, last_name)) LIKE ?", "%#{search.downcase}%")
    else
      Book.all
    end
  end
end