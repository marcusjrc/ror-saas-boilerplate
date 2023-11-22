# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def cancel_stripe_subscription
    Stripe::Subscription.update(subscription_id, { cancel_at_period_end: true })
    Stripe::Subscription.delete(subscription_id)
    update(status: Stripe::Subscription.retrieve(subscription_id).status)
  end
end
