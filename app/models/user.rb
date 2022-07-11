class User < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

end
