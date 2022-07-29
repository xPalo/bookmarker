FactoryBot.define do
  factory :user, class: User do

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    # after :create do |user|         # has_one
    #   create_list :author, 3, user_id: user.id
    # end

  end
end