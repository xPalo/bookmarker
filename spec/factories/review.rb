FactoryBot.define do
  factory :review, class: Review do

    association :user
    association :book

    user_id { :user_id }
    book_id { :book_id }
    score { rand(0..10) }
    body { Faker::Quote.matz }

  end
end