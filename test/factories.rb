# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
  end

  factory :link do
    url { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end
