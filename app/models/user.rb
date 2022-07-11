class User < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

end
