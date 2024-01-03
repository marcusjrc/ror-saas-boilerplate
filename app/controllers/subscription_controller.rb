class SubscriptionController < ApplicationController
  before_action :authenticate_user!
  def index
    @url = Stripe::BillingPortal::Session.create({
      customer: current_user.customer_id,
      return_url: subscription_index_url
    }).url
    @products = Product.all.order("price")
  end
end
