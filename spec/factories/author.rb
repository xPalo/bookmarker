FactoryBot.define do
  factory :author, class: Author do

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    country { Faker::Address.country }

  end
end