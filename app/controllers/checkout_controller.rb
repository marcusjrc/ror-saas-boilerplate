# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def create
    redirect_to root_url, notice: 'You already have an active subscription' && return if current_user.subscribed?
    price = params[:price_id]
    session = Stripe::Checkout::Session.create(
      customer: current_user.customer_id,
      client_reference_id: current_user.id,
      success_url: "#{root_url}checkout/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: subscription_index_url,
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price:
      }]
    )
    redirect_to session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    subscription = Stripe::Subscription.retrieve(session.subscription)
    product = Product.find_by(price_id: subscription.plan.id)

    redirect_to root_url and return if Subscription.exists?(subscription_id: subscription.id)

    Subscription.create(
      user: current_user,
      product:,
      current_period_start: Time.at(subscription.current_period_start),
      current_period_end: Time.at(subscription.current_period_end),
      interval: subscription.plan.interval,
      status: subscription.status,
      subscription_id: subscription.id
    )
    redirect_to root_url, notice: "Success! You are now subscribed as a #{product.title} member", allow_other_host: true
  end
end
