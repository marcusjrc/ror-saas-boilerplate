# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    begin
      event = Stripe::Event.construct_from(
        JSON.parse(request.raw_post, symbolize_names: true)
      )
    rescue JSON::ParserError
      head(:bad_request)
    end

    case event.type
    when 'customer.subscription.created'
      subscription = event.data.object
      subscription_obj = Subscription.find_by(subscription_id: subscription.id)
      return unless subscription_obj.nil?

      user = User.find_by!(customer_id: subscription.customer)
      unless user.subscription.nil?
        user.subscription = nil
        user.save
      end
      product = Product.find_by!(product_id: subscription.plan.product)
      Subscription.create(user:, product:, status: subscription.status, cancel_at_period_end: subscription.cancel_at_period_end, current_period_start: Time.at(subscription.current_period_start),
                          current_period_end: Time.at(subscription.current_period_end),
                          interval: subscription.plan.interval, subscription_id: subscription.id)
    when 'customer.subscription.updated'
      subscription = event.data.object
      subscription_obj = Subscription.find_by!(subscription_id: subscription.id)
      product = Product.find_by!(product_id: subscription.plan.product)
      subscription_obj.update(product:, status: subscription.status, cancel_at_period_end: subscription.cancel_at_period_end, current_period_start: Time.at(subscription.current_period_start),
                              current_period_end: Time.at(subscription.current_period_end),
                              interval: subscription.plan.interval)
    when 'customer.subscription.deleted', 'customer.subscription.paused', 'customer.subscription.resumed'
      subscription = event.data.object
      subscription_obj = Subscription.find_by!(subscription_id: subscription.id)
      subscription_obj.update(status: subscription.status, cancel_at_period_end: subscription.cancel_at_period_end, current_period_start: Time.at(subscription.current_period_start),
                              current_period_end: Time.at(subscription.current_period_end),
                              interval: subscription.plan.interval)
    else
      puts "Unhandled event type: #{event.type}"
    end

    head(:ok)
  end
end
