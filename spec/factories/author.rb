FactoryBot.define do
  factory :author, class: Author do

    association :user

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    country { Faker::Address.country }
    user_id { :user_id }

  end
end