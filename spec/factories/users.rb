FactoryBot.define do
  factory :user do
    email { Faker::Internet.username + "@bitscollege.edu.et" }
    password { Faker::Internet.password(min_length: 6) }
  end
end
