FactoryBot.define do
  factory :book, class: Book do

    association :author

    title { Faker::Book.title }
    isbn { Faker::Code.isbn  }
    notes { Faker::Quote.matz }
    author_id { :author_id }

  end
end