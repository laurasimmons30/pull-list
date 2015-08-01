require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:twitter_uid) { 5234567 }
    sequence(:username) { |n| "JoeCamel#{n}" }
  end

  factory :comic do
    sequence(:name) { "Batgirl" }
    sequence(:api_key) { 42604 }
  end

end
