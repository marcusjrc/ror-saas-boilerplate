FactoryBot.define do
  factory :user do
    customer_id { "12345" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password { "blabla" }
    first_name { "Bob" }
    last_name { "Dylan" }
  end

  trait :with_subscription do
    after(:create) do |user|
      product = create(:product)
      create(:subscription, product_id: product.id, user_id: user.id)
    end
  end
end
