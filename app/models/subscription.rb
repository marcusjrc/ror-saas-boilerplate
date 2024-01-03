class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_create_commit :create_notification

  def cancel_stripe_subscription
    Stripe::Subscription.update(subscription_id, {cancel_at_period_end: true})
    Stripe::Subscription.delete(subscription_id)
    update(status: Stripe::Subscription.retrieve(subscription_id).status)
  end

  def create_notification
    Notification.create(user:, content: "You are now a #{product.title} member. Manage your subscription here", url: subscription_index_path)
  end
end
