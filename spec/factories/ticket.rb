FactoryBot.define do
  factory :ticket do
    category { 1 }
    problem { "My computer has broken :(" }
  end
end
