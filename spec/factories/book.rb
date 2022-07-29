FactoryBot.define do
  factory :book, class: Book do

    association :author

    title { Faker::Book.title }
    title_sk { Faker::Book.title }
    isbn { Faker::Code.isbn  }
    author_id { :author_id }

  end
end