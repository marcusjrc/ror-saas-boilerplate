# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true

  after_save :assign_price_id
  def assign_price_id
    return unless price_id.blank? && product_id.blank?

    product = Stripe::Product.create(id:, name: title, type: 'service', description: content)
    price = Stripe::Price.create(product: product.id, currency:, unit_amount: self.price, recurring: { interval: 'month' })

    update(price_id: price.id, product_id: product.id)
  end

  def currency
    'gbp'
  end
end
