FactoryBot.define do
  factory :subscription do
    status { "trialing" }
    interval { "weekly" }
    subscription_id { "12345" }
    current_period_end { 7.days.from_now }
    current_period_start { Time.current }
  end
end
