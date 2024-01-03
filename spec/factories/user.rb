FactoryBot.define do
  factory :user do
    customer_id { "12345" }
    email { "bob@test.com" }
    password { "blabla" }
    first_name { "Bob" }
    last_name { "Dylan" }
  end
end
