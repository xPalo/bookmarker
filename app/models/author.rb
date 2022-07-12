class Author < ApplicationRecord

  has_many :books

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end